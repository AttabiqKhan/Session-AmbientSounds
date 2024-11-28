//
//  BottomTabBarView.swift
//  AmbientSoundApp
//
//  Created by Ali on 30/10/2024.
//

import Foundation
import UIKit

protocol BottomTabBarDelegate: AnyObject {
    func didSelectTab(_ tab: TabBarFeatures)
}

class BottomTabBarView: UIView {
    
    // MARK: - UI Elements
    private let borderView = View(backgroundColor: .greyishPurple)
    private let homeButton = TabBarButton(buttonText: "Home", buttonImage: "home_icon")
    private let soundsButton = TabBarButton(buttonText: "Sounds", buttonImage: "sounds_icon")
    private let addButton = ButtonWithImage(imageName: "add_icon", backgroundColor: .dustyOrange, cornerRadius: 40)
    private let exploreButton = TabBarButton(buttonText: "Explore", buttonImage: "explore_icon")
    private let libraryButton = TabBarButton(buttonText: "Library", buttonImage: "library_icon")
    
    // MARK: - Properties
    var delegate: BottomTabBarDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        setupViews()
        handleTaps()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupViews() {
        addSubview(borderView)
        addSubview(homeButton)
        addSubview(soundsButton)
        addSubview(addButton)
        addSubview(exploreButton)
        addSubview(libraryButton)
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1.autoSized),
            borderView.topAnchor.constraint(equalTo: self.topAnchor),
            
            homeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9.widthRatio),
            homeButton.topAnchor.constraint(equalTo: topAnchor),
            
            soundsButton.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor, constant: 5.widthRatio),
            soundsButton.topAnchor.constraint(equalTo: homeButton.topAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 80.autoSized),
            addButton.widthAnchor.constraint(equalToConstant: 80.autoSized),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -26.autoSized),
            
            exploreButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 5.autoSized),
            exploreButton.topAnchor.constraint(equalTo: homeButton.topAnchor),
            
            libraryButton.leadingAnchor.constraint(equalTo: exploreButton.trailingAnchor, constant: 5.widthRatio),
            libraryButton.topAnchor.constraint(equalTo: homeButton.topAnchor),
            libraryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9.widthRatio),
        ])
    }
    private func handleTaps() {
        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedHome)))
        soundsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedSounds)))
        addButton.addTarget(self, action: #selector(tappedAdd), for: .touchUpInside)
        exploreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedExplore)))
        exploreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedLibrary)))
    }
    
    // MARK: - Selectors
    @objc func tappedHome() {delegate?.didSelectTab(.home)}
    @objc func tappedSounds() {delegate?.didSelectTab(.sounds)}
    @objc func tappedAdd() {delegate?.didSelectTab(.add)}
    @objc func tappedExplore() {delegate?.didSelectTab(.explore)}
    @objc func tappedLibrary() {delegate?.didSelectTab(.library)}
}

class TabBarButton: UIView {
    
    // MARK: - UI Elements
    private let buttonImage = ImageView(imageName: "home_icon")
    private let buttonLabel: Label = {
        let label = Label(text: "Home", textAlignment: .center)
        label.font = .semiBold(ofSize: 11.autoSized)
        return label
    }()
    
    // MARK: - Initializers
    init(buttonText: String, buttonImage: String) {
        self.buttonImage.image = UIImage(named: buttonImage)
        self.buttonLabel.text = buttonText
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupViews() {
        addSubview(buttonImage)
        addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            buttonImage.topAnchor.constraint(equalTo: topAnchor, constant: 20.autoSized),
            buttonImage.heightAnchor.constraint(equalToConstant: 20.autoSized),
            buttonImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.widthRatio),
            buttonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.widthRatio),
            
            buttonLabel.topAnchor.constraint(equalTo: buttonImage.bottomAnchor, constant: 8.autoSized),
            buttonLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.autoSized),
        ])
    }
}
