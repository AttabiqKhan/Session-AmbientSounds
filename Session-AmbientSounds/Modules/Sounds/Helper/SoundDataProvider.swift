//
//  SoundDataProvider.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 14/01/2025.
//

import UIKit

class SoundDataProvider {
    
    static func getSoundCategories() -> [SoundCategory] {
        return [
            SoundCategory(title: "Nature", items: [
                SoundItem(name: "Rain", icon: UIImage(named: "rain"), backgroundColor: .rainColor),
                SoundItem(name: "Forest", icon: UIImage(named: "forest"), backgroundColor: .forestColor),
                SoundItem(name: "Scuba", icon: UIImage(named: "scuba"), backgroundColor: .scubaColor),
                SoundItem(name: "Birds", icon: UIImage(named: "birds"), backgroundColor: .birdsColor),
                SoundItem(name: "Waves", icon: UIImage(named: "waves"), backgroundColor: .wavesColor),
                SoundItem(name: "Droplets", icon: UIImage(named: "droplets"), backgroundColor: .dropletsColor),
            ]),
            SoundCategory(title: "Instruments", items: [
                SoundItem(name: "Piano", icon: UIImage(named: "piano"), backgroundColor: .pianoColor),
                SoundItem(name: "Orchestra", icon: UIImage(named: "orchestra"), backgroundColor: .orchestraColor),
                SoundItem(name: "Guitar", icon: UIImage(named: "guitar"), backgroundColor: .guitarColor),
                SoundItem(name: "Drums", icon: UIImage(named: "drums"), backgroundColor: .drumsColor),
            ]),
            SoundCategory(title: "Weather", items: [
                SoundItem(name: "Thunder", icon: UIImage(named: "thunder"), backgroundColor: .thunderColor),
                SoundItem(name: "Wind", icon: UIImage(named: "wind"), backgroundColor: .windColor),
                SoundItem(name: "Night", icon: UIImage(named: "night"), backgroundColor: .nightColor),
                SoundItem(name: "Morning", icon:UIImage(named: "morning"), backgroundColor: .morningColor),
                SoundItem(name: "Snow", icon:UIImage(named: "snow"), backgroundColor: .snowColor),
            ]),
            SoundCategory(title: "Cozy indoor", items: [
                SoundItem(name: "Coffee shop", icon: UIImage(named: "coffeeshop"), backgroundColor: .coffeeColor),
                SoundItem(name: "Fire", icon: UIImage(named: "fire"), backgroundColor: .fireColor),
                SoundItem(name: "Library", icon: UIImage(named: "library"), backgroundColor: .libraryColor),
            ])
        ]
    }
}
