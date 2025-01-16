//
//  SoundCategory.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 15/12/2024.
//

import Foundation
import UIKit

struct SoundCategory {
    let title: String
    let items: [SoundItem]
}

struct SoundItem {
    let name: String
    let icon: UIImage!
    let backgroundColor: UIColor
}
