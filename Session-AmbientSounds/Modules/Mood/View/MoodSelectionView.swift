//
//  MoodSelectionView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 17/11/2024.
//

// Discarded
import Foundation
import UIKit

class MoodSelectionView: UIView {
    
    private let lineView = View(backgroundColor: .lineColor, cornerRadius: 2.5)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How are you feeling\ntoday?"
        label.font = .bold(ofSize: 28.autoSized)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    private let emojiContainer = View(backgroundColor: .dimWhite, cornerRadius: 76.autoSized)
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(ofSize: 72.autoSized)
        label.textAlignment = .center
        return label
    }()
    private let moodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(ofSize: 28.autoSized)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
        private lazy var moodSlider: UISlider = {
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 4
            slider.value = 2 // Start at neutral
            slider.minimumTrackTintColor = .gray
            slider.maximumTrackTintColor = .lightGray
            slider.thumbTintColor = .purple
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return slider
        }()
//    private lazy var customSlider: CustomSliderView = {
//        let slider = CustomSliderView()
//        slider.minimumValue = 0
//        slider.maximumValue = 4
//        slider.currentValue = 2 // Start at neutral
//        slider.translatesAutoresizingMaskIntoConstraints = false
//        slider.delegate = self
//        return slider
//    }()
    //private let sliderContainer = View(backgroundColor: .systemCyan, cornerRadius: 24.autoSized)
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonSecondaryColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32.autoSized
        button.setTitle("Done", for: .normal)
        //button.titleLabel.font = .semiBold(ofSize: 16.autoSized)
        button.titleLabel?.font = UIFont(name: "Figtree-SemiBold", size: 16.autoSized)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    //private let navigationSlider = NavigationSlider()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        
        addSubview(lineView)
        addSubview(titleLabel)
        addSubview(emojiContainer)
        emojiContainer.addSubview(emojiLabel)
        addSubview(moodDescriptionLabel)
        //addSubview(sliderContainer)
        addSubview(moodSlider)
        addSubview(doneButton)
        //addSubview(navigationSlider)
        
        [lineView, titleLabel, emojiLabel, moodDescriptionLabel, moodSlider, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor, constant: 16.autoSized),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            lineView.heightAnchor.constraint(equalToConstant: 5.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32.autoSized),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emojiContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.autoSized),
            emojiContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiContainer.heightAnchor.constraint(equalToConstant: 152.autoSized),
            emojiContainer.widthAnchor.constraint(equalToConstant: 152.autoSized),
            
            emojiLabel.centerYAnchor.constraint(equalTo:emojiContainer.centerYAnchor),
            emojiLabel.centerXAnchor.constraint(equalTo: emojiContainer.centerXAnchor),
            
            moodDescriptionLabel.topAnchor.constraint(equalTo: emojiContainer.bottomAnchor, constant: 16.autoSized),
            moodDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            sliderContainer.topAnchor.constraint(equalTo: moodDescriptionLabel.bottomAnchor, constant: 32.autoSized),
//            sliderContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25.autoSized),
//            sliderContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25.autoSized),
//            sliderContainer.heightAnchor.constraint(equalToConstant: 48.autoSized),
            
            moodSlider.topAnchor.constraint(equalTo: moodDescriptionLabel.bottomAnchor, constant: 32.autoSized),
            moodSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25.autoSized),
            moodSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25.autoSized),
            
            doneButton.topAnchor.constraint(equalTo: moodSlider.bottomAnchor, constant: 57.autoSized),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25.autoSized),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25.autoSized),
            doneButton.heightAnchor.constraint(equalToConstant: 64.autoSized),
        ])
        
        updateMood(for: moodSlider.value)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        updateMood(for: sender.value)
    }
    
    private func updateMood(for value: Float) {
        let mood: (emoji: String, description: String, color: UIColor)
        
        switch value {
        case 0..<1:
            mood = ("😢", "Very Unpleasant", UIColor(red: 0.5, green: 0.2, blue: 0.7, alpha: 1.0)) // Replace with exact color
        case 1..<2:
            mood = ("😕", "Unpleasant", UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)) // Replace with exact color
        case 2..<3:
            mood = ("😐", "Neutral", UIColor(red: 0.3, green: 0.8, blue: 0.8, alpha: 1.0)) // Replace with exact color
        case 3..<4:
            mood = ("😊", "Pleasant", UIColor(red: 0.4, green: 0.8, blue: 0.6, alpha: 1.0)) // Replace with exact color
        default:
            mood = ("😁", "Very Pleasant", UIColor(red: 1.0, green: 0.8, blue: 0.3, alpha: 1.0)) // Replace with exact color
        }
        
        // Update UI components
        emojiLabel.text = mood.emoji
        moodDescriptionLabel.text = mood.description
        backgroundColor = mood.color.withAlphaComponent(0.1) // Adjust alpha as needed
        
    }
    @objc private func doneButtonTapped() {
        // Remove view when Done is tapped
        self.removeFromSuperview()
    }
}

//extension MoodSelectionView: CustomSliderViewDelegate {
//    func sliderValueDidChange(_ value: Float) {
//        updateMood(for: value)
//    }
//    
//    func leftButtonTapped() {
//        let newValue = max(customSlider.minimumValue, customSlider.currentValue - 1)
//               customSlider.currentValue = newValue
//               updateMood(for: newValue)
//    }
//    
//    func rightButtonTapped() {
//        let newValue = min(customSlider.maximumValue, customSlider.currentValue + 1)
//                customSlider.currentValue = newValue
//                updateMood(for: newValue)
//
//    }
//    
//    
//}
