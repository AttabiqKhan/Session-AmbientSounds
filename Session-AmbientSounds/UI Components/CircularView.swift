//
//  CircularView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 28/11/2024.
//

import UIKit

class CircularView: UIView {
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
}
