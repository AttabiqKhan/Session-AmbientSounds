//
//  SoundMix.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 01/01/2025.
//

import UIKit

struct SoundMix {
    let id: String
    let title: String
    let mainIcon: String
    var sounds: [Sound]
    var isFavorite: Bool
}

struct Sound {
    let id: String
    let name: String
    var icon: String {
        return "\(name.lowercased())"
    }
    var tintColor: UIColor {
        return colorForSoundName(name)
    }
}
