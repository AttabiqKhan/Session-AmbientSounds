//
//  ImageView.swift
//
//
//  Created by Attabiq Khan on 23/09/2024.
//

import UIKit

class ImageView: UIImageView {

    init(imageName: String, cornerRadius: CGFloat = 0, backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        //self.image = UIImage(named: imageName)
        self.image = UIImage()
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        return
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
