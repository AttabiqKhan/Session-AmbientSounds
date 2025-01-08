//
//  LibraryManager.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 03/01/2025.
//

import Foundation

protocol LibraryManagerDelegate: AnyObject {
    func libraryDidUpdate()
}

class LibraryManager {
    
    static let shared = LibraryManager()
    private var items: [LibraryItems] = []
    weak var delegate: LibraryManagerDelegate?
    
    private init() {
        loadItemsFromCoreData()
    }
    
    private func loadItemsFromCoreData() {
        items = CoreDataManager.shared.fetchAllLibraryItems()
    }
    func refreshItems() {
        loadItemsFromCoreData()
        delegate?.libraryDidUpdate()
    }
    func addToLibrary(_ item: LibraryItems) -> Bool {
        let isDuplicate = items.contains { existingItem in
            existingItem.title == item.title &&
            existingItem.soundTypes == item.soundTypes
        }
        
        if !isDuplicate {
            items.insert(item, at: 0)
            CoreDataManager.shared.saveLibraryItem(item)
            delegate?.libraryDidUpdate()
        }
        return isDuplicate
    }
    func removeFromLibrary(id: String) {
        items.removeAll(where: { $0.id == id })
        CoreDataManager.shared.deleteLibraryItem(id: id)
        delegate?.libraryDidUpdate()
    }
    func getLibraryItems() -> [LibraryItems] {
        return items
    }
}
