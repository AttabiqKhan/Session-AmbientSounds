//
//  View.swift
//
//
//  Created by Attabiq Khan on 23/09/2024.
//

import UIKit

class View: UIView {

    init(
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0
    ) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
