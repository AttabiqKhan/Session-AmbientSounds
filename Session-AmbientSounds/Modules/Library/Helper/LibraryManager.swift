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
    private init() {}
    
    private var items: [LibraryItems] = []
    weak var delegate: LibraryManagerDelegate?
    
    func addToLibrary(_ item: LibraryItems) {
        if !items.contains(where: { $0.title == item.title }) {
            items.insert(item, at: 0)
            delegate?.libraryDidUpdate()
        }
    }
    func removeFromLibrary(id: String) {
        items.removeAll(where: { $0.id == id })
        delegate?.libraryDidUpdate()
    }
    func getLibraryItems() -> [LibraryItems] {
        return items
    }
}
