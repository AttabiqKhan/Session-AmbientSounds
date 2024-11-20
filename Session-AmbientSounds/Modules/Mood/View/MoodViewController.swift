//
//  MoodViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 18/11/2024.
//

import Foundation
import UIKit

enum MoodStates {
    case veryUnpleasant
    case unpleasant
    case neutral
    case pleasant
    case veryPleasant
    
    var emoji: String {
        switch self {
        case .veryUnpleasant:
            return "😢"
        case .unpleasant:
            return "😕"
        case .neutral:
            return "😐"
        case .pleasant:
            return "😊"
        case .veryPleasant:
            return "😁"
        }
    }
    
    var description: String {
        switch self {
        case .veryUnpleasant:
            return "Very Unpleasant"
        case .unpleasant:
            return "Unpleasant"
        case .neutral:
            return "Neutral"
        case .pleasant:
            return "Pleasant"
        case .veryPleasant:
            return "Very Pleasant"
        }
    }
    
    // Helper method to return the Mood based on slider value
    static func mood(for value: CGFloat) -> MoodStates {
        switch value {
        case 0.0..<0.2:
            return .veryUnpleasant
        case 0.2..<0.4:
            return .unpleasant
        case 0.4..<0.6:
            return .neutral
        case 0.6..<0.8:
            return .pleasant
        case 0.8..<1.0:
            return .veryPleasant
        default:
            return .veryPleasant 
        }
    }
}

class MoodViewController: UIViewController {
    
    private let containerView = View(backgroundColor: .white)
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lineColor
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How are you feeling\ntoday?"
        label.font = .boldSystemFont(ofSize: 28.autoSized)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let emojiContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 76.autoSized
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(ofSize: 72.autoSized)
        label.text = "😢"
        label.textAlignment = .center
        return label
    }()
    
    private let moodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28.autoSized)
        label.textColor = .darkGray
        label.text = "Very Unpleasant"
        label.textAlignment = .center
        return label
    }()
    
    //    private lazy var moodSlider: UISlider = {
    //        let slider = UISlider()
    //        slider.minimumValue = 0
    //        slider.maximumValue = 4
    //        slider.value = 2 // Start at neutral
    //        slider.minimumTrackTintColor = .gray
    //        slider.maximumTrackTintColor = .lightGray
    //        slider.thumbTintColor = .purple
    //        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    //        return slider
    //    }()
    //        private lazy var moodSlider: CustomSliderView = {
    //            let slider = CustomSliderView()
    //            slider.minimumValue = 0
    //            slider.maximumValue = 4
    //            slider.currentValue = 2 // Start at neutral
    //            slider.translatesAutoresizingMaskIntoConstraints = false
    ////            slider.delegate = self
    //            return slider
    //        }()
    private lazy var moodSlider: CustomSlider = {
        let slider = CustomSlider()
        slider.delegate = self
        return slider
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonSecondaryColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32.autoSized
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "Figtree-SemiBold", size: 16.autoSized)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        [lineView, titleLabel, emojiContainer, emojiLabel, moodDescriptionLabel, moodSlider, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(containerView)
        containerView.addSubview(lineView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(emojiContainer)
        containerView.addSubview(moodDescriptionLabel)
        containerView.addSubview(moodSlider)
        containerView.addSubview(doneButton)
        emojiContainer.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lineView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.autoSized),
            lineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            lineView.heightAnchor.constraint(equalToConstant: 5.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32.autoSized),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            emojiContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.autoSized),
            emojiContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emojiContainer.heightAnchor.constraint(equalToConstant: 152.autoSized),
            emojiContainer.widthAnchor.constraint(equalToConstant: 152.widthRatio),
            
            emojiLabel.centerYAnchor.constraint(equalTo: emojiContainer.centerYAnchor),
            emojiLabel.centerXAnchor.constraint(equalTo: emojiContainer.centerXAnchor),
            
            moodDescriptionLabel.topAnchor.constraint(equalTo: emojiContainer.bottomAnchor, constant: 16.autoSized),
            moodDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            moodSlider.topAnchor.constraint(equalTo: moodDescriptionLabel.bottomAnchor, constant: 32.autoSized),
            moodSlider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            moodSlider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            
            doneButton.topAnchor.constraint(equalTo: moodSlider.bottomAnchor, constant: 57.autoSized),
            doneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 64.autoSized),
            doneButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -32.autoSized)
        ])
        
        //updateMood(for: moodSlider.currentValue)
    }
    
    //    @objc private func sliderValueChanged(_ sender: UISlider) {
    //        updateMood(for: sender.value)
    //    }
    
    //    private func updateMood(for value: Float) {
    //        let mood: (emoji: String, description: String, color: UIColor)
    //
    //        switch value {
    //        case 0..<1:
    //            mood = ("😢", "Very Unpleasant", UIColor(red: 0.5, green: 0.2, blue: 0.7, alpha: 1.0))
    //        case 1..<2:
    //            mood = ("😕", "Unpleasant", UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0))
    //        case 2..<3:
    //            mood = ("😐", "Neutral", UIColor(red: 0.3, green: 0.8, blue: 0.8, alpha: 1.0))
    //        case 3..<4:
    //            mood = ("😊", "Pleasant", UIColor(red: 0.4, green: 0.8, blue: 0.6, alpha: 1.0))
    //        default:
    //            mood = ("😁", "Very Pleasant", UIColor(red: 1.0, green: 0.8, blue: 0.3, alpha: 1.0))
    //        }
    //
    //        emojiLabel.text = mood.emoji
    //        moodDescriptionLabel.text = mood.description
    //    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MoodViewController: CustomSliderDelegate {
    
    func customSliderDidChangeValue(_ slider: CustomSlider, value: CGFloat) {
        let mood = MoodStates.mood(for: value)
        emojiLabel.text = mood.emoji
        moodDescriptionLabel.text = mood.description
    }
}
