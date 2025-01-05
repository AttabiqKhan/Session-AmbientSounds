//
//  LibraryData.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 03/01/2025.
//

import UIKit

struct LibraryData {
    static let data: [(title: String, icon: String, soundTypes: [LibraryCell.SoundType])] = [
        (title: "Rainy Day", icon: "rainy_day", soundTypes: [
            LibraryCell.SoundType(icon: "rain"),
            LibraryCell.SoundType(icon: "droplets"),
            LibraryCell.SoundType(icon: "thunder"),
            LibraryCell.SoundType(icon: "coffeeshop")
        ]),
        (title: "Cozy Forest", icon: "forest", soundTypes: [
            LibraryCell.SoundType(icon: "birds"),
            LibraryCell.SoundType(icon: "wind"),
            LibraryCell.SoundType(icon: "forest"),
            LibraryCell.SoundType(icon: "scuba"),
            LibraryCell.SoundType(icon: "birds")
        ]),
        (title: "Ocean Waves", icon: "ocean", soundTypes: [
            LibraryCell.SoundType(icon: "waves"),
            LibraryCell.SoundType(icon: "piano"),
            LibraryCell.SoundType(icon: "orchestra"),
        ]),
        (title: "Intimate Night", icon: "intimate_night", soundTypes: [
            LibraryCell.SoundType(icon: "night"),
            LibraryCell.SoundType(icon: "guitar"),
            LibraryCell.SoundType(icon: "fire"),
            LibraryCell.SoundType(icon: "pleasant")
        ]),
        (title: "Stress Relief", icon: "stress_relief", soundTypes: [
            LibraryCell.SoundType(icon: "fire"),
            LibraryCell.SoundType(icon: "birds"),
            LibraryCell.SoundType(icon: "coffeeshop"),
            LibraryCell.SoundType(icon: "orchestra")
        ]),
        (title: "Tropical Paradise", icon: "library", soundTypes: [
            LibraryCell.SoundType(icon: "waves"),
            LibraryCell.SoundType(icon: "wind")
        ])
    ]
}
