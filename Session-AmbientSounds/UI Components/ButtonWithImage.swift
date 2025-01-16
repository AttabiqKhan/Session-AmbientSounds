//
//  ButtonWithImage.swift
//  UIComponents
//
//  Created by Attabiq Khan on 30/10/2024.
//

import Foundation
import UIKit

public class ButtonWithImage: UIButton {
    public init(imageName: String = "", backgroundColor: UIColor = .clear, cornerRadius: Int = 0) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: imageName), for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius.autoSized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
