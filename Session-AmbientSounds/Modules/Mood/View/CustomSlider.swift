//
//  CustomSlider.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 18/11/2024.
//

import Foundation
import UIKit

protocol CustomSliderDelegate: AnyObject {
    // This value is from 0 - 1 which represents the percentage of the x position of the slider
    func customSliderDidChangeValue(_ slider: CustomSlider, value: CGFloat)
}

class CustomSlider: UIView {
    
    private let circularButton: CircularView = {
        let button = CircularView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        
        // Shadow properties
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false // Ensure shadow isn't clipped
        
        return button
    }()
    private let leftImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.left")
        iv.tintColor = .gray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let rightImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .gray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    // Property to store the button's initial position
    private var circularButtonInitialX: CGFloat = 4
    
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
    
    weak var delegate: CustomSliderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Setup slider background
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .sliderContainerColor
        self.layer.borderColor = UIColor.sliderBorderColor.cgColor
        self.layer.borderWidth = 1
        
        // Add circular button
        addSubview(circularButton)
        circularButton.addSubview(leftImage)
        circularButton.addSubview(rightImage)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48.autoSized),
            
            circularButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: circularButtonInitialX),
            circularButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 3.autoSized),
            circularButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3.autoSized),
            circularButton.widthAnchor.constraint(equalTo: circularButton.heightAnchor),
            
            leftImage.leadingAnchor.constraint(equalTo: circularButton.leadingAnchor, constant: 6.widthRatio),
            leftImage.widthAnchor.constraint(equalToConstant: 4.widthRatio),
            leftImage.heightAnchor.constraint(equalToConstant: 8.autoSized),
            leftImage.centerYAnchor.constraint(equalTo: circularButton.centerYAnchor),
            
            rightImage.trailingAnchor.constraint(equalTo: circularButton.trailingAnchor, constant: -6.widthRatio),
            rightImage.widthAnchor.constraint(equalToConstant: 4.widthRatio),
            rightImage.heightAnchor.constraint(equalToConstant: 8.autoSized),
            rightImage.centerYAnchor.constraint(equalTo: circularButton.centerYAnchor),
        ])
        
        // Add Pan Gesture Recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        circularButton.addGestureRecognizer(panGesture)
        circularButton.isUserInteractionEnabled = true
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        gesture.setTranslation(.zero, in: self) // Reset translation to avoid compounding
        
        // Calculate the new x position based on the translation
        let newX = circularButton.frame.origin.x + translation.x
        
        // Constrain the new x position within bounds
        let minX = 4.0 // Left padding
        let maxX = self.bounds.width - circularButton.bounds.width - 4.0 // Right padding
        
        // Ensure the new x position stays within bounds
        let constrainedX = max(minX, min(newX, maxX))
        
        // Update the circular button's position
        circularButton.frame.origin.x = constrainedX
        
        // Calculate the percentage value (0 to 1)
        let sliderWidth = self.bounds.width - circularButton.bounds.width - 8.0 // Total width minus padding
        let value = (constrainedX - minX) / sliderWidth
        
        // Notify delegate of the updated value
        delegate?.customSliderDidChangeValue(self, value: value)
    }
}

class CircularView: UIView {
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
}
