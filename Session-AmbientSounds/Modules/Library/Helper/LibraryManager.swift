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

//class LibraryManager {
//    static let shared = LibraryManager()
//    private init() {}
//    
//    private var items: [LibraryItems] = []
//    weak var delegate: LibraryManagerDelegate?
//    
//    func addToLibrary(_ item: LibraryItems) {
//        if !items.contains(where: { $0.title == item.title }) {
//            items.insert(item, at: 0)
//            delegate?.libraryDidUpdate()
//        }
//    }
//    func removeFromLibrary(id: String) {
//        items.removeAll(where: { $0.id == id })
//        delegate?.libraryDidUpdate()
//    }
//    func getLibraryItems() -> [LibraryItems] {
//        return items
//    }
//}
class LibraryManager {
    static let shared = LibraryManager()
    private init() {
        loadItemsFromCoreData()
    }
    
    private var items: [LibraryItems] = []
    weak var delegate: LibraryManagerDelegate?
    
    private func loadItemsFromCoreData() {
        items = CoreDataManager.shared.fetchAllLibraryItems()
    }
    
    func addToLibrary(_ item: LibraryItems) -> Bool {
//        if !items.contains(where: { $0.title == item.title }) {
//            items.insert(item, at: 0)
//            CoreDataManager.shared.saveLibraryItem(item)
//            delegate?.libraryDidUpdate()
//        }
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
