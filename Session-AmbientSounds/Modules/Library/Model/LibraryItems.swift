//
//  LibraryItem.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 03/01/2025.
//

import Foundation

struct LibraryItems {
    let id: String
    var title: String
    let icon: String
    let soundTypes: [LibraryCell.SoundType]
    
    init(id: String = UUID().uuidString,
         title: String,
         icon: String,
         soundTypes: [LibraryCell.SoundType]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.soundTypes = soundTypes
    }
}
