//
//  StackView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 28/12/2024.
//

import UIKit

class StackView: UIStackView {
    
    init(
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

