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
    private let lineView = View(backgroundColor: .lineColor, cornerRadius: 2.5)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.textColor = .titleColor
        label.font = .bold(ofSize: 33.autoSized)
        return label
    }()
    private let favouriteContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 28.autoSized
        container.layer.borderColor = UIColor.imageContainerBorderColor.cgColor
        container.layer.borderWidth = 1
        return container
    }()
    private let favouriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "favourite")
        return iv
    }()
    private let libraryContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 28.autoSized
        container.layer.borderColor = UIColor.imageContainerBorderColor.cgColor
        container.layer.borderWidth = 1
        return container
    }()
    private let libraryImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "add_to_library")
        return iv
    }()
    private let playView: UIView = {
        let container = UIView()
        container.backgroundColor = .midnightPurple
        container.layer.cornerRadius = 40.autoSized
        container.layer.borderWidth = 1
        return container
    }()
    private lazy var playImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "play_button")
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayButton))
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    private let volumeIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "volume")
        return iv
    }()
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.tintColor = .midnightPurple
        slider.thumbTintColor = .midnightPurple
        slider.addTarget(self, action: #selector(didChangeVolume(_:)), for: .valueChanged)
        return slider
    }()
    private let recommendedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended sounds"
        label.textAlignment = .left
        label.textColor = .titleColor
        label.font = .bold(ofSize: 28.autoSized)
        return label
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
    private let playingSoundsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6.autoSized
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let volumeControlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.autoSized
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    private var player: AVAudioPlayer!
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addPanGesture()
        setupAudioSession()
        playInitialAudio()
        setupInitialPlayingView()
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        [
            titleLabel,
            favouriteContainer,
            favouriteImageView,
            libraryContainer,
            libraryImageView,
            playView,
            playImageView,
            volumeIcon,
            volumeSlider,
            recommendedLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
            containerView.addSubview(
                $0
            )
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavouriteView))
        favouriteContainer.addGestureRecognizer(tapGesture)
    }
    private func setupInitialPlayingView() {
        // Add one initial dummy playing view
        addPlayingSoundView(for: "Rain")
    }
    private func addPlayingSoundView(for soundName: String) {
        
        let backgroundColor = colorForSoundName(soundName)
        let playingSoundView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 16.autoSized
            view.backgroundColor = backgroundColor
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
            view.layer.borderWidth = 1.3
            return view
        }()
        let playingSoundImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: soundName.lowercased())
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
        let container: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let playingSoundView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 28.autoSized
            view.backgroundColor = backgroundColor
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
            view.layer.borderWidth = 0.8
            return view
        }()
        let playingSoundImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: soundName.lowercased())
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        let volumeSlider: UISlider = {
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.value = 0.65
            slider.tintColor = .midnightPurple
            slider.thumbTintColor = .midnightPurple
            slider.translatesAutoresizingMaskIntoConstraints = false
            return slider
        }()
        
        volumeControlStackView.addArrangedSubview(container)
        container.addSubview(playingSoundView)
        container.addSubview(volumeSlider)
        playingSoundView.addSubview(playingSoundImage)
        
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
            
            volumeSlider.leadingAnchor.constraint(equalTo: playingSoundView.trailingAnchor, constant: 16.autoSized),
            volumeSlider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
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
    private func playInitialAudio() {
        playAudio(forPlayer: &player)
    }
    private func playAudio(forPlayer player: inout AVAudioPlayer?) {
        let fileName = "rain" // Hardcoded file name, need to change later
        let fileExtension = "mp3" // Hardcoded file extension, need to change later
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Audio file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.volume = volumeSlider.value
            player?.play()
        } catch {
            print("Error initializing player: \(error.localizedDescription)")
        }
    }
    private func playSound(for index: Int) {
        player.stop()
        player.currentTime = 0
        let option = recommendedSounds[index].name.lowercased()
        
        // Check if the tapped audio is already playing
        if let player = players[index], player.isPlaying {
            // Pause the currently playing audio for this cell
            print("Pausing audio for option: \(option)")
            player.stop()
            toggleSound(option)
            players[index] = nil
            return
        } else {
            // Stop, reset, and play all other audio players from the beginning
            for (i, otherPlayer) in players.enumerated() {
                if let otherPlayer = otherPlayer {
                    // Stop and reset other players
                    print("Stopping and resetting audio for option: \(recommendedSounds[i].name.lowercased())")
                    otherPlayer.stop() // Stop the audio
                    otherPlayer.currentTime = 0 // Reset to the beginning
                    otherPlayer.play() // Start the audio again from the beginning
                }
            }
            if players.compactMap({ $0 }).count >= 4 {
                let alertController = AlertController(title: "Sorry! We can’t add more sounds :(")
                alertController.presentAlert(from: self, duration: 6.0)
                return
            }
            // Create or reset the player for the tapped audio
            if players[index] == nil {
                // Create a new player for the tapped audio
                guard let url = Bundle.main.url(forResource: option, withExtension: "mp3") else {
                    print("Audio file not found for option: \(option)")
                    return
                }
                do {
                    let newPlayer = try AVAudioPlayer(contentsOf: url)
                    newPlayer.numberOfLoops = -1
                    newPlayer.volume = volumeSlider.value
                    players[index] = newPlayer
                    newPlayer.play()  // Play the new audio
                    toggleSound(option)
                    print("Playing new audio for option: \(option)")
                } catch {
                    print("Error initializing player for option \(option): \(error.localizedDescription)")
                }
            } else {
                // If the player exists, reset it to the beginning and play
                //players[index]?.currentTime = 0
                players[index]?.play()
                print("Playing audio for option: \(option) from the beginning.")
            }
        }
        player.play()
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
    private func updatePlayingImage() {
        if player.isPlaying {
            playImageView.image = UIImage(named: "pause_button")
        } else {
            playImageView.image = UIImage(named: "play_button")
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
        let controller = RenamingViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.delegate = self
        controller.initialValue = titleLabel.text
        self.present(controller, animated: false)
    }
    @objc private func didTapPlayButton() {
        if let player = player, player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        updatePlayingImage()
    }
    @objc private func didChangeVolume(_ sender: UISlider) {
        player?.volume = sender.value
    }
}

// MARK: - For updation of value
extension PlayViewController: ValuePassingDelegate {
    
    func didEnterValue(_ value: String) {
        titleLabel.text = value
        favouriteImageView.image = UIImage(named: "favourite_done")
    }
}

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
        let value = indexPath.item
        playSound(for: value)
    }
}
