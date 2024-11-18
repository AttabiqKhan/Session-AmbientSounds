//
//  CustomSliderView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 18/11/2024.
//

import UIKit

// Protocol to handle slider actions
protocol CustomSliderViewDelegate: AnyObject {
    func sliderValueDidChange(_ value: Float)
    func leftButtonTapped()
    func rightButtonTapped()
}

class CustomSliderView: UIView {
    // MARK: - Properties
    weak var delegate: CustomSliderViewDelegate?
    
    let navigationSlider: NavigationSlider = {
        let slider = NavigationSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    // Public access to configure slider
    var minimumValue: Float {
        get { navigationSlider.slider.minimumValue }
        set { navigationSlider.slider.minimumValue = newValue }
    }
    
    var maximumValue: Float {
        get { navigationSlider.slider.maximumValue }
        set { navigationSlider.slider.maximumValue = newValue }
    }
    
    var currentValue: Float {
        get { navigationSlider.slider.value }
        set { navigationSlider.slider.setValue(newValue, animated: true) }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(navigationSlider)
        
        NSLayoutConstraint.activate([
            navigationSlider.topAnchor.constraint(equalTo: topAnchor),
            navigationSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            navigationSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Setup default values
        navigationSlider.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        navigationSlider.onLeftButtonTap = { [weak self] in
            self?.delegate?.leftButtonTapped()
        }
        navigationSlider.onRightButtonTap = { [weak self] in
            self?.delegate?.rightButtonTapped()
        }
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        delegate?.sliderValueDidChange(sender.value)
    }
}
