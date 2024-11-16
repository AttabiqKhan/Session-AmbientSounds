//
//  Button.swift
// 
//
//  Created by Attabiq Khan on 23/09/2024.
//

import UIKit

class Button: UIButton {
    
    init(type: UIButton.ButtonType = .system, image: UIImage?, tintColor: UIColor = .black) {
        super.init(frame: .zero)
        self.tintColor = tintColor
        self.setImage(image, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
