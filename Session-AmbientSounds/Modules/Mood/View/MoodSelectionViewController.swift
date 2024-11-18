//
//  MoodSelectionViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 17/11/2024.
//

//import Foundation
//import UIKit
//
//class MoodSelectionViewController: UIViewController {
//
//    // UI Elements
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "How are you feeling today?"
//        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24) // Custom font if specified
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let emojiLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 80) // Adjust to design size
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let moodDescriptionLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20) // Custom font if specified
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let moodSlider: UISlider = {
//        let slider = UISlider()
//        slider.minimumValue = 0
//        slider.maximumValue = 4
//        slider.value = 2 // Starting from Neutral
//        slider.minimumTrackTintColor = .gray // Color for the filled part
//        slider.maximumTrackTintColor = .lightGray // Color for unfilled part
//        slider.thumbTintColor = .purple // Customize thumb color
//        return slider
//    }()
//
//    private lazy var doneButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Done", for: .normal)
//        button.backgroundColor = .purple
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 12
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
//        return button
//    }()
//   
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        updateMood(for: moodSlider.value)
//        moodSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
//    }
//
//    private func setupUI() {
//        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 20
//
//        // Add subviews
//        view.addSubview(titleLabel)
//        view.addSubview(emojiLabel)
//        view.addSubview(moodDescriptionLabel)
//        view.addSubview(moodSlider)
//        view.addSubview(doneButton)
//        
//        // Layout constraints
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
//        moodDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        moodSlider.translatesAutoresizingMaskIntoConstraints = false
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            emojiLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            emojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            moodDescriptionLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 10),
//            moodDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            moodSlider.topAnchor.constraint(equalTo: moodDescriptionLabel.bottomAnchor, constant: 30),
//            moodSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            moodSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            
//            doneButton.topAnchor.constraint(equalTo: moodSlider.bottomAnchor, constant: 30),
//            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            doneButton.widthAnchor.constraint(equalToConstant: 120),
//            doneButton.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//
//    @objc private func sliderValueChanged(_ sender: UISlider) {
//        updateMood(for: sender.value)
//    }
//
//    private func updateMood(for value: Float) {
//        let mood: (emoji: String, description: String, color: UIColor)
//
//        switch value {
//        case 0..<1:
//            mood = ("😢", "Very Unpleasant", UIColor(red: 0.5, green: 0.2, blue: 0.7, alpha: 1.0)) // Replace with exact color
//        case 1..<2:
//            mood = ("😕", "Unpleasant", UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)) // Replace with exact color
//        case 2..<3:
//            mood = ("😐", "Neutral", UIColor(red: 0.3, green: 0.8, blue: 0.8, alpha: 1.0)) // Replace with exact color
//        case 3..<4:
//            mood = ("😊", "Pleasant", UIColor(red: 0.4, green: 0.8, blue: 0.6, alpha: 1.0)) // Replace with exact color
//        default:
//            mood = ("😁", "Very Pleasant", UIColor(red: 1.0, green: 0.8, blue: 0.3, alpha: 1.0)) // Replace with exact color
//        }
//
//        // Update UI components
//        emojiLabel.text = mood.emoji
//        moodDescriptionLabel.text = mood.description
//        view.backgroundColor = mood.color.withAlphaComponent(0.1) // Adjust alpha as needed
//        moodSlider.thumbTintColor = mood.color // Thumb color to match mood color
//        moodSlider.minimumTrackTintColor = mood.color
//    }
//
//    @objc private func doneButtonTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//}
