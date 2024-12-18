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
    
    // MARK: - UI Elements
    private let circularButton: CircularView = {
        let button = CircularView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 2.autoSized, height: 2.autoSized)
        button.layer.shadowRadius = 4.autoSized
        button.layer.masksToBounds = false
        return button
    }()
    private let leftImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "left_chevron")
        iv.tintColor = .gray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let rightImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "right_chevron")
        iv.tintColor = .gray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - Properties
    private var circularButtonInitialX: CGFloat = 4
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
    weak var delegate: CustomSliderDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .sliderContainerColor
        self.layer.borderColor = UIColor.sliderBorderColor.cgColor
        self.layer.borderWidth = 1
        
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
            leftImage.widthAnchor.constraint(equalToConstant: 4.autoSized),
            leftImage.heightAnchor.constraint(equalToConstant: 8.autoSized),
            leftImage.centerYAnchor.constraint(equalTo: circularButton.centerYAnchor),
            
            rightImage.trailingAnchor.constraint(equalTo: circularButton.trailingAnchor, constant: -6.widthRatio),
            rightImage.widthAnchor.constraint(equalToConstant: 4.autoSized),
            rightImage.heightAnchor.constraint(equalToConstant: 8.autoSized),
            rightImage.centerYAnchor.constraint(equalTo: circularButton.centerYAnchor),
        ])
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        circularButton.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Selectors
    // Note: handlePanGesture function may seem difficult to understand hence the comments are written
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

