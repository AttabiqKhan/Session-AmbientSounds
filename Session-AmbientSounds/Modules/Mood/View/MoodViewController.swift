//
//  MoodViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 18/11/2024.
//

import Foundation
import UIKit

enum MoodStates {
    case unpleasant
    case slightlyUnpleasant
    case neutral
    case slightlyPleasant
    case pleasant
    
//    var emoji: String {
//        switch self {
//        case .unpleasant:
//            return "😢"
//        case .slightlyUnpleasant:
//            return "😕"
//        case .neutral:
//            return "😐"
//        case .slightlyPleasant:
//            return "😊"
//        case .pleasant:
//            return "😁"
//        }
//    }
    
    var description: String {
        switch self {
        case .unpleasant:
            return "Unpleasant"
        case .slightlyUnpleasant:
            return "Slightly Unpleasant"
        case .neutral:
            return "Neutral"
        case .slightlyPleasant:
            return "Slightly Pleasant"
        case .pleasant:
            return "Pleasant"
        }
    }
    
    // Helper method to return the Mood based on slider value
    static func mood(for value: CGFloat) -> MoodStates {
        switch value {
        case 0.0..<0.2:
            return .unpleasant
        case 0.2..<0.4:
            return .slightlyUnpleasant
        case 0.4..<0.6:
            return .neutral
        case 0.6..<0.8:
            return .slightlyPleasant
        case 0.8..<1.0:
            return .pleasant
        default:
            return .pleasant
        }
    }
}

class MoodViewController: UIViewController {
    
    // MARK: - UI Elements
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
    private let gradientViewContainer: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear // Set the background color to clear
        imageView.image = UIImage(named: "unpleasant")
//        imageView.clipsToBounds = true // Ensure the image respects the corner radius
        imageView.contentMode = .scaleAspectFill // Adjust image scaling behavior
        return imageView
    }()
    private let emojiContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .dimWhite
        view.layer.cornerRadius = 76.autoSized
        return view
    }()
    private let emojiImageContainer: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear // Set the background color to clear
        imageView.image = UIImage(named: "unpleasant_emoji")
//        imageView.clipsToBounds = true // Ensure the image respects the corner radius
        imageView.contentMode = .scaleAspectFill // Adjust image scaling behavior
        return imageView
    }()
//    private let emojiLabel: UILabel = {
//        let label = UILabel()
//        label.font = .poppinsMedium(ofSize: 72.autoSized)
//        label.text = "😢"
//        label.textAlignment = .center
//        return label
//    }()
    private let moodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28.autoSized)
        label.textColor = .darkGray
        label.text = "Unpleasant"
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
        
        [lineView, titleLabel, emojiContainer, emojiImageContainer, moodDescriptionLabel, moodSlider, doneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(containerView)
        
        [lineView, titleLabel, moodDescriptionLabel, moodSlider, doneButton, gradientViewContainer].forEach {
            containerView.addSubview($0)
        }
        gradientViewContainer.addSubview(emojiContainer)
        emojiContainer.addSubview(emojiImageContainer)
        
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
            
            gradientViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            gradientViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gradientViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gradientViewContainer.heightAnchor.constraint(equalToConstant: 200.autoSized),
            
            emojiContainer.centerYAnchor.constraint(equalTo: gradientViewContainer.centerYAnchor),
            emojiContainer.centerXAnchor.constraint(equalTo: gradientViewContainer.centerXAnchor),
            emojiContainer.heightAnchor.constraint(equalToConstant: 152.autoSized),
            emojiContainer.widthAnchor.constraint(equalToConstant: 152.autoSized),
            
            emojiImageContainer.centerYAnchor.constraint(equalTo: emojiContainer.centerYAnchor),
            emojiImageContainer.centerXAnchor.constraint(equalTo: emojiContainer.centerXAnchor),
            
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
        //emojiLabel.text = mood.emoji
        moodDescriptionLabel.text = mood.description
        gradientViewContainer.image = UIImage(named: "\(moodDescriptionLabel.text?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")")
        emojiImageContainer.image = UIImage(named: "\(moodDescriptionLabel.text?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")_emoji")
    }
}
