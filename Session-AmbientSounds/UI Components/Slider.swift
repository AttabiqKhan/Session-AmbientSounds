//
//  Slider.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 28/12/2024.
//

import UIKit

class Slider: UISlider {
    init(
        minimumValue: Float = 0,
        maximumValue: Float = 1,
        value: Float = 1.0,
        tintColor: UIColor = .black,
        thumbTintColor: UIColor = .black
    ) {
        super.init(frame: .zero)
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.value = value
        self.tintColor = tintColor
        self.thumbTintColor = thumbTintColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

