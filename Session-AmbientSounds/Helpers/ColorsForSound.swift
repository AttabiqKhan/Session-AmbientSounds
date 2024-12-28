//
//  ColorsForSound.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 17/12/2024.
//

import UIKit

func colorForSoundName(_ soundName: String) -> UIColor {
    switch soundName.lowercased() {
    case "rain": 
        return .rainColor
    case "forest": 
        return .forestColor
    case "scuba": 
        return .scubaColor
    case "birds": 
        return .birdsColor
    case "waves": 
        return .wavesColor
    case "droplets": 
        return .dropletsColor
    case "piano": 
        return .pianoColor
    case "orchestra": 
        return .orchestraColor
    case "guitar": 
        return .guitarColor
    case "drums": 
        return .drumsColor
    case "thunder": 
        return .thunderColor
    case "wind": 
        return .windColor
    case "night": 
        return .nightColor
    case "morning": 
        return .morningColor
    case "snow": 
        return .snowColor
    case "coffeeshop": 
        return .coffeeColor
    case "fire": 
        return .fireColor
    case "library": 
        return .libraryColor
    default: return .gray // Default color for unrecognized sound names
    }
}
