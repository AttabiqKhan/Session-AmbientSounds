//
//  PlayViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 28/11/2024.
//

import Foundation
import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = View(backgroundColor: .white)
    private let lineView = View(
        backgroundColor: .lineColor,
        cornerRadius: 2.5
    )
    private let titleLabel: Label = {
        let label = Label(
            text: "Title",
            textAlignment: .center,
            textColor: .titleColor
        )
        label.font = .bold(ofSize: 33.autoSized)
        return label
    }()
    private lazy var favouriteContainer: View = {
        let container = View(
            backgroundColor: .clear,
            cornerRadius: 28.autoSized
        )
        container.layer.borderColor = UIColor.imageContainerBorderColor.cgColor
        container.layer.borderWidth = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavouriteView))
        container.addGestureRecognizer(tapGesture)
        return container
    }()
    private let favouriteImageView = ImageView(imageName: "favourite")
    private let libraryContainer: View = {
        let container = View(
            backgroundColor: .clear,
            cornerRadius: 28.autoSized
        )
        container.layer.borderColor = UIColor.imageContainerBorderColor.cgColor
        container.layer.borderWidth = 1
        return container
    }()
    private let libraryImageView = ImageView(imageName: "add_to_library")
    private let playView: View = {
        let container = View(
            backgroundColor: .midnightPurple,
            cornerRadius: 40.autoSized
        )
        container.layer.borderWidth = 1
        return container
    }()
    private let playImageView = ImageView(imageName: "play_button")
    private let volumeIcon = ImageView(imageName: "volume")
    private let recommendedLabel: Label = {
        let label = Label(
            text: "Recommended sounds",
            textAlignment: .left,
            textColor: .titleColor
        )
        label.font = .bold(ofSize: 28.autoSized)
        return label
    }()
    private lazy var volumeSlider: Slider = {
        let slider = Slider(
            minimumValue: 0,
            maximumValue: 1,
            value: 1.0,
            tintColor: .midnightPurple,
            thumbTintColor: .midnightPurple
        )
        slider.addTarget(self, action: #selector(didChangeVolume(_:)), for: .valueChanged)
        return slider
    }()
    private let mixSoundsLabel: Label = {
        let label = Label(text: "Mix Sounds", textColor: .titleColor)
        label.font = .bold(ofSize: 19.autoSized)
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 73.autoSized, height: 94.autoSized)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16.autoSized
        layout.minimumInteritemSpacing = 16.widthRatio
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecommendedSoundCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedSoundCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private let playingSoundsStackView = StackView(
        axis: .horizontal,
        spacing: 6.autoSized,
        alignment: .fill,
        distribution: .fill
    )
    private let volumeControlStackView = StackView(
        axis: .vertical,
        spacing: 16.autoSized,
        alignment: .fill,
        distribution: .fill
    )

    // MARK: - Properties
    private var recommendedSounds: [SoundItem] = [
        SoundItem(name: "Piano", icon: UIImage(named: "piano"), backgroundColor: .pianoColor),
        SoundItem(name: "Birds", icon: UIImage(named: "birds"), backgroundColor: .birdsColor),
        SoundItem(name: "Forest", icon: UIImage(named: "forest"), backgroundColor: .forestColor),
        SoundItem(name: "Guitar", icon: UIImage(named: "guitar"), backgroundColor: .guitarColor),
        SoundItem(name: "Wind", icon: UIImage(named: "wind"), backgroundColor: .windColor),
        SoundItem(name: "Orchestra", icon: UIImage(named: "orchestra"), backgroundColor: .orchestraColor),
        SoundItem(name: "Library", icon: UIImage(named: "library"), backgroundColor: .libraryColor),
        SoundItem(name: "Night", icon: UIImage(named: "night"), backgroundColor: .nightColor),
    ]
    private lazy var players: [AVAudioPlayer?] = Array(repeating: nil, count: recommendedSounds.count)
    private var playingSounds: [String] = []
    private var individualVolumes: [String: Float] = [:]
    private var initialSoundTitle: String
    
    // MARK: - Initializers
    init(initialSoundTitle: String) {
        self.initialSoundTitle = initialSoundTitle
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addPanGesture()
        setupAudioSession()
        CoreDataManager.shared.fetchAllLibraryItems()
        playSound(for: initialSoundTitle)
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        titleLabel.text = initialSoundTitle.capitalized
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.addSubview(containerView)
        [
            titleLabel,
            lineView,
            favouriteContainer,
            volumeSlider,
            libraryContainer,
            playView,
            volumeIcon,
            recommendedLabel,
            collectionView,
            playingSoundsStackView,
            mixSoundsLabel,
            volumeControlStackView
        ].forEach {
            containerView.addSubview($0)
        }
        favouriteContainer.addSubview(favouriteImageView)
        libraryContainer.addSubview(libraryImageView)
        playView.addSubview(playImageView)
        
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
            
            playingSoundsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.autoSized),
            playingSoundsStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            playingSoundsStackView.heightAnchor.constraint(equalToConstant: 32.autoSized),
            
            favouriteContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 59.widthRatio),
            favouriteContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178.autoSized),
            favouriteContainer.heightAnchor.constraint(equalToConstant: 56.autoSized),
            favouriteContainer.widthAnchor.constraint(equalToConstant: 56.autoSized),
            
            favouriteImageView.centerXAnchor.constraint(equalTo: favouriteContainer.centerXAnchor),
            favouriteImageView.centerYAnchor.constraint(equalTo: favouriteContainer.centerYAnchor),
            
            libraryContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -59.widthRatio),
            libraryContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178.autoSized),
            libraryContainer.heightAnchor.constraint(equalToConstant: 56.autoSized),
            libraryContainer.widthAnchor.constraint(equalToConstant: 56.autoSized),
            
            libraryImageView.centerXAnchor.constraint(equalTo: libraryContainer.centerXAnchor),
            libraryImageView.centerYAnchor.constraint(equalTo: libraryContainer.centerYAnchor),
            
            playView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            playView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 166.autoSized),
            playView.heightAnchor.constraint(equalToConstant: 80.autoSized),
            playView.widthAnchor.constraint(equalToConstant: 80.autoSized),
            
            playImageView.centerXAnchor.constraint(equalTo: playView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: playView.centerYAnchor),
            
            volumeIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 270.autoSized),
            volumeIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            volumeIcon.heightAnchor.constraint(equalToConstant: 24.autoSized),
            volumeIcon.widthAnchor.constraint(equalToConstant: 24.autoSized),
            
            volumeSlider.topAnchor.constraint(equalTo: favouriteContainer.bottomAnchor, constant: 45.autoSized),
            volumeSlider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 57.widthRatio),
            volumeSlider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            volumeSlider.heightAnchor.constraint(equalToConstant: 6.autoSized),
            
            mixSoundsLabel.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 32.autoSized),
            mixSoundsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            mixSoundsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            
            volumeControlStackView.topAnchor.constraint(equalTo: mixSoundsLabel.bottomAnchor, constant: 24.autoSized),
            volumeControlStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            volumeControlStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            
            recommendedLabel.topAnchor.constraint(equalTo: volumeControlStackView.bottomAnchor, constant: 32.autoSized),
            recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            recommendedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            
            collectionView.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor, constant: 24.autoSized),
            collectionView.heightAnchor.constraint(equalToConstant: 220.autoSized),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            collectionView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -0.autoSized)
        ])
    }
    private func setupInitialPlayingView() {
        // Add one initial dummy playing view
        addPlayingSoundView(for: "Rain")
        addVolumeView(for: "Rain")
    }
    private func addPlayingSoundView(for soundName: String) {
        
        let backgroundColor = colorForSoundName(soundName)
        let playingSoundView: View = {
            let view = View(backgroundColor: backgroundColor, cornerRadius: 16.autoSized)
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
            view.layer.borderWidth = 1.3
            return view
        }()
        let playingSoundImage: ImageView = {
            let imageView = ImageView(imageName: soundName.lowercased())
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        playingSoundsStackView.addArrangedSubview(playingSoundView)
        playingSoundView.addSubview(playingSoundImage)
        
        NSLayoutConstraint.activate([
            playingSoundView.heightAnchor.constraint(equalToConstant: 32.autoSized),
            playingSoundView.widthAnchor.constraint(equalToConstant: 32.autoSized),
            
            playingSoundImage.centerXAnchor.constraint(equalTo: playingSoundView.centerXAnchor),
            playingSoundImage.centerYAnchor.constraint(equalTo: playingSoundView.centerYAnchor),
            playingSoundImage.heightAnchor.constraint(equalTo: playingSoundView.heightAnchor, multiplier: 0.8),
            playingSoundImage.widthAnchor.constraint(equalTo: playingSoundView.widthAnchor, multiplier: 0.8)
        ])
    }
    private func addVolumeView(for soundName: String) {
        let backgroundColor = colorForSoundName(soundName)

        let container = View()
        let playingSoundView: View = {
            let view = View(backgroundColor: backgroundColor, cornerRadius: 28.autoSized)
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
            view.layer.borderWidth = 0.8
            return view
        }()
        let playingSoundImage: ImageView = {
            let imageView = ImageView(imageName: soundName.lowercased())
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        let crossButton: Button = {
            let button = Button(type: .system, image: UIImage(named: "cross_button")?.withRenderingMode(.alwaysTemplate), tintColor: .white)
            button.layer.cornerRadius = 8.autoSized
            button.backgroundColor = .titleColor
            button.accessibilityIdentifier = soundName
            button.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
            return button
        }()
        let volumeSlider: Slider = {
            let slider = Slider(
                minimumValue: 0,
                maximumValue: 1,
                value: 1.0,
                tintColor: .midnightPurple,
                thumbTintColor: .midnightPurple
            )
            slider.accessibilityIdentifier = soundName
            individualVolumes[soundName.lowercased()] = 1.0
            slider.addTarget(self, action: #selector(volumeSliderValueChanged(_:)), for: .valueChanged)
            return slider
        }()

        volumeControlStackView.addArrangedSubview(container)
        container.addSubview(playingSoundView)
        container.addSubview(volumeSlider)
        playingSoundView.addSubview(playingSoundImage)
        playingSoundView.addSubview(crossButton)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 56.autoSized),
            
            playingSoundView.heightAnchor.constraint(equalToConstant: 56.autoSized),
            playingSoundView.widthAnchor.constraint(equalToConstant: 56.autoSized),
            playingSoundView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            playingSoundView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            playingSoundImage.centerXAnchor.constraint(equalTo: playingSoundView.centerXAnchor),
            playingSoundImage.centerYAnchor.constraint(equalTo: playingSoundView.centerYAnchor),
            playingSoundImage.heightAnchor.constraint(equalToConstant: 20.autoSized),
            playingSoundImage.widthAnchor.constraint(equalToConstant: 20.autoSized),
            
            crossButton.topAnchor.constraint(equalTo: playingSoundView.topAnchor),
            crossButton.leadingAnchor.constraint(equalTo: playingSoundView.leadingAnchor),
            crossButton.widthAnchor.constraint(equalToConstant: 16.autoSized),
            crossButton.heightAnchor.constraint(equalToConstant: 16.autoSized),
            
            volumeSlider.leadingAnchor.constraint(equalTo: playingSoundView.trailingAnchor, constant: 16.autoSized),
            volumeSlider.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.autoSized),
            volumeSlider.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            volumeSlider.heightAnchor.constraint(equalToConstant: 6.autoSized)
        ])
    }
    private func removeVolumeView(for soundName: String) {
        // Find and remove the container view that matches the sound name
        for arrangedSubview in volumeControlStackView.arrangedSubviews {
            // Check if this container has the playingSoundView with matching image
            if let playingSoundView = arrangedSubview.subviews.first(where: { $0.subviews.first is UIImageView }),
               let imageView = playingSoundView.subviews.first as? UIImageView,
               imageView.image == UIImage(named: soundName.lowercased()) {
                
                // Remove the container from the stack view
                arrangedSubview.removeFromSuperview()
                
                // Animate the removal if needed
                UIView.animate(withDuration: 0.2) {
                    self.volumeControlStackView.layoutIfNeeded()
                }
                break
            }
        }
    }
    private func removePlayingSoundView(for soundName: String) {
        // Remove view from stack view
        for arrangedSubview in playingSoundsStackView.arrangedSubviews {
            if let imageView = arrangedSubview.subviews.compactMap({ $0 as? UIImageView }).first,
               imageView.image == UIImage(named: soundName.lowercased()) {
                playingSoundsStackView.removeArrangedSubview(arrangedSubview)
                arrangedSubview.removeFromSuperview()
                break
            }
        }
    }
    private func toggleSound(_ soundName: String) {
        if playingSounds.contains(soundName) {
            // Stop sound and remove the view
            playingSounds.removeAll { $0 == soundName }
            removePlayingSoundView(for: soundName)
            removeVolumeView(for: soundName)
        } else {
            // Play sound and add the view
            playingSounds.append(soundName)
            addPlayingSoundView(for: soundName)
            addVolumeView(for: soundName)
        }
    }
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                options: [.mixWithOthers, .duckOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    private func playSound(for soundName: String) {
        //let option = soundName.lowercased()
        
        // Find index of existing player for this sound
        let existingPlayerIndex = players.firstIndex(where: { player in
            if let player = player,
               let playerURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                return player.url == playerURL && player.isPlaying
            }
            return false
        })
        // If sound is already playing, stop it
        if existingPlayerIndex != nil {
            let alertController = AlertController(title: "Sound is already playing") // design needed
            alertController.presentAlert(from: self, duration: 1.0)
            return
        }
        // Count active players and stop if limit reached
        if players.compactMap({ $0 }).count >= 5 {
            let alertController = AlertController(title: "Sorry! We can't add more sounds :(")
            alertController.presentAlert(from: self, duration: 1.5)
            return
        }
        // Find first available slot in players array
        guard let emptyIndex = players.firstIndex(where: { $0 == nil }) else {
            print("No available slots for new audio player")
            return
        }
        // Create new player
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Audio file not found for option: \(soundName)")
            return
        }
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.numberOfLoops = -1
            newPlayer.volume = volumeSlider.value
            players[emptyIndex] = newPlayer
            newPlayer.play()
            toggleSound(soundName)
            print("Playing new audio for option: \(soundName)")
        } catch {
            print("Error initializing player for option \(soundName): \(error.localizedDescription)")
        }
    }
    private func stopSound(for soundName: String) {
        //let option = soundName.lowercased()
        
        // Find the player that's playing this sound
        if let index = players.firstIndex(where: { player in
            if let player = player,
               let playerURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                return player.url == playerURL
            }
            return false
        }) {
            players[index]?.stop()
            players[index]?.currentTime = 0
            players[index] = nil
        } else {
            print("No active player found for sound: \(soundName)")
        }
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
    @objc private func didTapFavouriteView() {
        guard let currentTitle = titleLabel.text else { return }

        // Check if the current mix is already in the library
        if let currentID = getCurrentLibraryItemID() {
            let alert = AlertController(title: "\(currentTitle) removed from favorites")
            // If it exists, remove it
            LibraryManager.shared.removeFromLibrary(id: currentID)
            updateFavoriteButton(isFavorite: false)
            alert.presentAlert(from: self)
        } else {
            // If it doesn't exist, open the renaming controller for the user to name it
            let controller = RenamingViewController()
            controller.modalPresentationStyle = .overCurrentContext
            controller.delegate = self
            controller.initialValue = titleLabel.text
            self.present(controller, animated: false)
        }
    }
    @objc private func didChangeVolume(_ sender: UISlider) {
        let masterVolume = sender.value
        
        // Update all active players with new master volume
        for (_, player) in players.enumerated() {
            guard let player = player,
                  let url = player.url,
                  let soundName = url.deletingPathExtension().lastPathComponent.lowercased() as String? else {
                continue
            }
            
            // Get individual volume for this sound
            let individualVolume = individualVolumes[soundName] ?? 1.0
            
            // Calculate final volume as a product of master and individual volumes
            player.volume = masterVolume * individualVolume
        }
    }
    @objc private func volumeSliderValueChanged(_ sender: UISlider) {
        guard let soundName = sender.accessibilityIdentifier?.lowercased() else { return }
        
        // Find the player for this sound
        let player = players.first(where: { player in
            guard let player = player,
                  let url = player.url,
                  let playerSoundName = url.deletingPathExtension().lastPathComponent.lowercased() as String? else {
                return false
            }
            return playerSoundName == soundName
        })
        
        guard let audioPlayer = player else { return }
        
        let individualVolume = sender.value
        individualVolumes[soundName] = individualVolume
        
        // Calculate final volume using master volume
        audioPlayer?.volume = volumeSlider.value * individualVolume
    }
    @objc private func didTapDismissButton(_ sender: UIButton) {
        if players.compactMap({ $0 }).count == 1 {
            let alertController = AlertController(title: "One audio should be playing!") //design implementation needed
            alertController.presentAlert(from: self, duration: 1.0)
            return
        }
        guard let soundName = sender.accessibilityIdentifier else { return }
        stopSound(for: soundName)
        playingSounds.removeAll { $0 == soundName }
        removeVolumeView(for: soundName)
        removePlayingSoundView(for: soundName)
    }
}

// MARK: - For updation of value and adding it to the library
extension PlayViewController: ValuePassingDelegate {
    
    func didEnterValue(_ value: String) {
        let newLibraryItem = LibraryItems(
            title: value,
            icon: "cozy_fire",  // You can modify this based on your needs
            soundTypes: getCurrentPlayingSoundTypes()
        )
        
        LibraryManager.shared.addToLibrary(newLibraryItem)
        titleLabel.text = value
        updateFavoriteButton(isFavorite: true)
    }
    private func updateFavoriteButton(isFavorite: Bool) {
        if isFavorite {
            favouriteImageView.image = UIImage(named: "favourite_done")
        } else {
            favouriteImageView.image = UIImage(named: "favourite")
        }
    }
    private func getCurrentPlayingSoundTypes() -> [LibraryCell.SoundType] {
        return playingSounds.map { soundName in
            LibraryCell.SoundType(icon: soundName.lowercased())
        }
    }
    private func getCurrentLibraryItemID() -> String? {
        // Match the current playing sound types to find the corresponding library item
        let playingSoundTypes = getCurrentPlayingSoundTypes()
        return LibraryManager.shared.getLibraryItems()
            .first(where: { $0.soundTypes == playingSoundTypes })?.id
    }
}

// MARK: - Collection View Delegate & Data Source
extension PlayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedSounds.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedSoundCollectionViewCell.identifier,
            for: indexPath
        ) as? RecommendedSoundCollectionViewCell else {
            return UICollectionViewCell()
        }
        let soundItem = recommendedSounds[indexPath.item]
        cell.configure(with: soundItem)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = recommendedSounds[indexPath.item]
        let sanitizedString = value.name.lowercased().replacingOccurrences(of: " ", with: "")
        playSound(for: sanitizedString)
    }
}
