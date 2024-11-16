//
//  Text Field.swift
//
//
//  Created by Attabiq Khan on 23/09/2024.
//

import UIKit

class TextField: UITextField {

    init(borderStyle: UITextField.BorderStyle = .roundedRect, placeHolder: String = "") {
        super.init(frame: .zero)
        self.borderStyle = borderStyle
        self.placeholder = placeHolder
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
