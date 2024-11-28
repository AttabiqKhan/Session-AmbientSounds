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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addPanGesture()
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        [lineView, titleLabel, emojiContainer, emojiLabel, moodDescriptionLabel, moodSlider, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(containerView)
        
        [lineView, titleLabel, emojiContainer, moodDescriptionLabel, moodSlider, doneButton].forEach {
            containerView.addSubview($0)
        }
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
            emojiContainer.widthAnchor.constraint(equalToConstant: 152.autoSized),
            
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
    }
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    private func dismissSelf() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
            self.view.backgroundColor = .clear
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    private func presentSelf() {
        containerView.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.containerView.transform = .identity
        }
    }
    
    // MARK: - Selectors
    // Note: handlePanGesture function may seem difficult to understand hence the comments are written
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        // Get the vertical translation of the gesture relative to the containerView.
        let translation = gesture.translation(in: containerView)
        
        // Calculate the progress of the drag as a fraction of the containerView's height.
        let progress = translation.y / containerView.bounds.height
        
        switch gesture.state {
        case .changed:
            // If the user is dragging downwards (positive Y direction), update the containerView's position.
            if translation.y > 0 {
                containerView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            
        case .ended, .cancelled:
            // Get the vertical velocity of the gesture.
            let velocity = gesture.velocity(in: containerView).y
            
            // Determine if the gesture should result in dismissing the view.
            // Conditions:
            // 1. Drag progress exceeds 30% of the containerView's height.
            // 2. Gesture velocity exceeds 1000 points per second in the downward direction.
            let shouldDismiss = progress > 0.3 || velocity > 1000
            if shouldDismiss {
                // If dismiss conditions are met, dismiss the view.
                dismissSelf()
            } else {
                // If dismiss conditions are not met, animate the containerView back to its original position.
                UIView.animate(withDuration: 0.3) {
                    self.containerView.transform = .identity
                }
            }
            
        default:
            // Do nothing for other gesture states.
            break
        }
    }
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - To handle the changes when slider is moved
extension MoodViewController: CustomSliderDelegate {
    
    func customSliderDidChangeValue(_ slider: CustomSlider, value: CGFloat) {
        let mood = MoodStates.mood(for: value)
        emojiLabel.text = mood.emoji
        moodDescriptionLabel.text = mood.description
    }
}
