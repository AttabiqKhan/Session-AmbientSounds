//
//  UIViewExtensions.swift
//  AppExtensions
//
//  Created by Attabiq Khan on 30/10/2024.
//

import Foundation
import UIKit

extension UIView {
    func addGradient(
        colors: [UIColor],
        locations: [NSNumber]? = [0.0, 1.0],
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
    ) {
        backgroundColor = .clear
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
