//
//  NavigationSlider.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 18/11/2024.
//

import UIKit

class NavigationSlider: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray3
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 4
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.setThumbImage(UIImage(), for: .normal)
        slider.alpha = 0
        return slider
    }()
    
    private let trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        return view
    }()
    var onLeftButtonTap: (() -> Void)?
    var onRightButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Add and configure stack view
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Add track view behind slider
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(trackView)
        stackView.addArrangedSubview(rightButton)
        
        // Add slider on top of track view
        trackView.addSubview(slider)
        
        // Configure button sizes
        leftButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Setup constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            slider.topAnchor.constraint(equalTo: trackView.topAnchor),
            slider.bottomAnchor.constraint(equalTo: trackView.bottomAnchor),
            slider.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trackView.trailingAnchor)
        ])
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        trackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup button actions
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc private func leftButtonTapped() {
            let newValue = max(slider.minimumValue, slider.value - 1)
            slider.setValue(newValue, animated: true)
            slider.sendActions(for: .valueChanged)
            onLeftButtonTap?()
        }
        
        @objc private func rightButtonTapped() {
            let newValue = min(slider.maximumValue, slider.value + 1)
            slider.setValue(newValue, animated: true)
            slider.sendActions(for: .valueChanged)
            onRightButtonTap?()
        }
}
