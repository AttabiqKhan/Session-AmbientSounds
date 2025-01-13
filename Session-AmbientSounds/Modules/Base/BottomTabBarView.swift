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
    private let soundsButton = TabBarButton(buttonText: "Sounds", buttonImage: "sounds_icon_unselected")
    private let addButton = ButtonWithImage(imageName: "add_icon", backgroundColor: .dustyOrange, cornerRadius: 40)
    private let exploreButton = TabBarButton(buttonText: "Explore", buttonImage: "explore_icon_unselected")
    private let libraryButton = TabBarButton(buttonText: "Library", buttonImage: "library_icon_unselected")
    
    // MARK: - Properties
    var delegate: BottomTabBarDelegate?
    private var selectedTab: TabBarFeatures = .home {
        didSet {
            updateTabAppearance()
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        setupViews()
        handleTaps()
        updateTabAppearance()
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
        libraryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedLibrary)))
    }
    private func updateTabAppearance() {
        homeButton.buttonImage.image = UIImage(named: "home_icon_unselected")
        soundsButton.buttonImage.image = UIImage(named: "sounds_icon_unselected")
        exploreButton.buttonImage.image = UIImage(named: "explore_icon_unselected")
        libraryButton.buttonImage.image = UIImage(named: "library_icon_unselected")
        homeButton.buttonLabel.textColor = .neutralGray
        soundsButton.buttonLabel.textColor = .neutralGray
        exploreButton.buttonLabel.textColor = .neutralGray
        libraryButton.buttonLabel.textColor = .neutralGray
        
        switch selectedTab {
        case .home:
            homeButton.buttonImage.image = UIImage(named: "home_icon")
            homeButton.buttonLabel.textColor = .lavenderMist
        case .sounds:
            soundsButton.buttonImage.image = UIImage(named: "sounds_icon")
            soundsButton.buttonLabel.textColor = .lavenderMist
        case .explore:
            exploreButton.buttonImage.image = UIImage(named: "explore_icon")
            exploreButton.buttonLabel.textColor = .lavenderMist
        case .library:
            libraryButton.buttonImage.image = UIImage(named: "library_icon")
            libraryButton.buttonLabel.textColor = .lavenderMist
        case .add:
            break
        }
    }

    // MARK: - Selectors
    @objc func tappedHome() {
        selectedTab = .home
        delegate?.didSelectTab(.home)
    }
    @objc func tappedSounds() {
        selectedTab = .sounds
        delegate?.didSelectTab(.sounds)
    }
    @objc func tappedAdd() {
        delegate?.didSelectTab(.add)
    }
    @objc func tappedExplore() {
        selectedTab = .explore
        delegate?.didSelectTab(.explore)
    }
    @objc func tappedLibrary() {
        selectedTab = .library
        delegate?.didSelectTab(.library)
    }
}

class TabBarButton: UIView {
    
    // MARK: - UI Elements
    let buttonImage = ImageView(imageName: "home_icon_unselected")
    let buttonLabel: Label = {
        let label = Label(text: "Home", textAlignment: .center, textColor: .neutralGray)
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
