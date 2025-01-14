//
//  TabBarManager.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 13/01/2025.
//

import Foundation

class TabBarManager {
    
    static let shared = TabBarManager()
    var currentTab: TabBarFeatures = .home {
        didSet {
            observers.forEach { $0.value(currentTab) }
        }
    }
    private var observers: [String: (TabBarFeatures) -> Void] = [:]
    
    private init() {}
    
    func addObserver(id: String, observer: @escaping (TabBarFeatures) -> Void) {
        observers[id] = observer
    }
    func removeObserver(id: String) {
        observers.removeValue(forKey: id)
    }
}

