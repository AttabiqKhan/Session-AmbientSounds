//
//  Label.swift
//
//
//  Created by Attabiq Khan on 23/09/2024.
//

import UIKit

class Label: UILabel {

    init(text: String, textAlignment: NSTextAlignment = .left, numberOfLines: Int = .min, textColor: UIColor = .black) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
