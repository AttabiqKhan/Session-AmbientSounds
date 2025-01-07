//
//  CoreDataManager.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 05/01/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {
        loadPersistentStore()
    }
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LibraryData")
        return container
    }()
    private lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private func loadPersistentStore() {
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    // MARK: - CRUD Operations with LibraryItems model
    func saveLibraryItem(_ item: LibraryItems) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibraryItem")
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        
        do {
            let existingObjects = try viewContext.fetch(fetchRequest)
            
            // If item exists, update it. If not, create new.
            let managedObject: NSManagedObject
            if let existingObject = existingObjects.first {
                managedObject = existingObject
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "LibraryItem", in: viewContext)!
                managedObject = NSManagedObject(entity: entity, insertInto: viewContext)
            }
            
            // Set values
            managedObject.setValue(item.id, forKey: "id")
            managedObject.setValue(item.title, forKey: "title")
            managedObject.setValue(item.icon, forKey: "icon")
            
            // Convert soundTypes to Data
            if let soundTypesData = try? JSONEncoder().encode(item.soundTypes) {
                managedObject.setValue(soundTypesData, forKey: "soundTypesData")
            }
            
            try viewContext.save()
        } catch {
            print("Error saving library item: \(error)")
        }
    }
    func fetchAllLibraryItems() -> [LibraryItems] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibraryItem")
        
        do {
            let managedObjects = try viewContext.fetch(fetchRequest)
            return managedObjects.compactMap { object -> LibraryItems? in
                guard let id = object.value(forKey: "id") as? String,
                      let title = object.value(forKey: "title") as? String,
                      let icon = object.value(forKey: "icon") as? String,
                      let soundTypesData = object.value(forKey: "soundTypesData") as? Data,
                      let soundTypes = try? JSONDecoder().decode([LibraryCell.SoundType].self, from: soundTypesData) else {
                    return nil
                }
                
                return LibraryItems(
                    id: id,
                    title: title,
                    icon: icon,
                    soundTypes: soundTypes
                )
            }
        } catch {
            print("Error fetching library items: \(error)")
            return []
        }
    }
    func deleteLibraryItem(id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibraryItem")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            objects.forEach { viewContext.delete($0) }
            try viewContext.save()
        } catch {
            print("Error deleting library item: \(error)")
        }
    }
    func renameLibraryItem(id: String, newName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibraryItem")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            if let item = objects.first {
                item.setValue(newName, forKey: "title")  // Assuming "title" is your attribute name
                try viewContext.save()
            }
        } catch {
            print("Error renaming library item: \(error)")
        }
    }
}
