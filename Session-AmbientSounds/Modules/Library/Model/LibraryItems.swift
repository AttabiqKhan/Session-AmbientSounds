//
//  LibraryItem.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 03/01/2025.
//

import Foundation

struct LibraryItems {
    let title: String
    let icon: String
    let soundTypes: [LibraryCell.SoundType]
    
    init(title: String,
         icon: String,
         soundTypes: [LibraryCell.SoundType]) {
        self.title = title
        self.icon = icon
        self.soundTypes = soundTypes
    }
}
