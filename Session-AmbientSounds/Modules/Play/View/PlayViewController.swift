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
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    private let waveView: WaveView = {
        let view = WaveView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let containerView = View(backgroundColor: .white, cornerRadius: 40.autoSized)
    private let secondaryContainer = View(backgroundColor: .white)
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
    private lazy var dismissImageView: ImageView = {
        let iv = ImageView(imageName: "dismiss")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismissView)))
        return iv
    }()
    
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
    private var isAlreadyFavorite: Bool = false
    private var topConstraint: NSLayoutConstraint!
    private var originalTopConstant: CGFloat = 392.autoSized // Original position
    private var collapsedTopConstant: CGFloat = 0
    
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
        setupAudioSession()
        playSound(for: initialSoundTitle)
        setupPanGesture()
    }
    
    // MARK: - Functions
    private func setupUI() {
        topConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 442.autoSized)
        view.backgroundColor = .white
        titleLabel.text = initialSoundTitle.capitalized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(dismissImageView)
        view.addSubview(waveView)
        view.addSubview(containerView)
        view.addSubview(scrollView)
        scrollView.addSubview(secondaryContainer)
        containerView.addSubview(titleLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(favouriteContainer)
        containerView.addSubview(volumeSlider)
        containerView.addSubview(libraryContainer)
        containerView.addSubview(playView)
        containerView.addSubview(volumeIcon)
        secondaryContainer.addSubview(recommendedLabel)
        secondaryContainer.addSubview(collectionView)
        containerView.addSubview(playingSoundsStackView)
        secondaryContainer.addSubview(mixSoundsLabel)
        secondaryContainer.addSubview(volumeControlStackView)
        favouriteContainer.addSubview(favouriteImageView)
        libraryContainer.addSubview(libraryImageView)
        playView.addSubview(playImageView)
        
        NSLayoutConstraint.activate([
            dismissImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            dismissImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.autoSized),
            dismissImageView.heightAnchor.constraint(equalToConstant: 32.autoSized),
            dismissImageView.widthAnchor.constraint(equalToConstant: 32.autoSized),
            
            waveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            waveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            waveView.topAnchor.constraint(equalTo: dismissImageView.bottomAnchor, constant: 2.autoSized),
            waveView.heightAnchor.constraint(equalToConstant: 442.autoSized),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topConstraint,
            containerView.heightAnchor.constraint(equalToConstant: 334.autoSized),
            
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
            
            secondaryContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            secondaryContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            secondaryContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            secondaryContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            secondaryContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mixSoundsLabel.topAnchor.constraint(equalTo: secondaryContainer.topAnchor),
            mixSoundsLabel.leadingAnchor.constraint(equalTo: secondaryContainer.leadingAnchor, constant: 25.widthRatio),
            mixSoundsLabel.trailingAnchor.constraint(equalTo: secondaryContainer.trailingAnchor, constant: -25.widthRatio),
            
            volumeControlStackView.topAnchor.constraint(equalTo: mixSoundsLabel.bottomAnchor, constant: 24.autoSized),
            volumeControlStackView.leadingAnchor.constraint(equalTo: secondaryContainer.leadingAnchor, constant: 25.widthRatio),
            volumeControlStackView.trailingAnchor.constraint(equalTo: secondaryContainer.trailingAnchor, constant: -25.widthRatio),
            
            recommendedLabel.topAnchor.constraint(equalTo: volumeControlStackView.bottomAnchor, constant: 32.autoSized),
            recommendedLabel.leadingAnchor.constraint(equalTo: secondaryContainer.leadingAnchor, constant: 25.widthRatio),
            recommendedLabel.trailingAnchor.constraint(equalTo: secondaryContainer.trailingAnchor, constant: -25.widthRatio),
            
            collectionView.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor, constant: 24.autoSized),
            collectionView.leadingAnchor.constraint(equalTo: secondaryContainer.leadingAnchor, constant: 20.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: secondaryContainer.trailingAnchor, constant: -20.widthRatio),
            collectionView.heightAnchor.constraint(equalToConstant: 241.autoSized),
            collectionView.bottomAnchor.constraint(equalTo: secondaryContainer.bottomAnchor)
        ])
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
        for arrangedSubview in volumeControlStackView.arrangedSubviews {
            if let playingSoundView = arrangedSubview.subviews.first(where: { $0.subviews.first is UIImageView }),
               let imageView = playingSoundView.subviews.first as? UIImageView,
               imageView.image == UIImage(named: soundName.lowercased()) {
                arrangedSubview.removeFromSuperview()
                UIView.animate(withDuration: 0.2) {
                    self.volumeControlStackView.layoutIfNeeded()
                }
                break
            }
        }
    }
    private func removePlayingSoundView(for soundName: String) {
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
            playingSounds.removeAll { $0 == soundName }
            removePlayingSoundView(for: soundName)
            removeVolumeView(for: soundName)
            setupWaves(playingSounds.count) //Updated Waves
        } else {
            playingSounds.append(soundName)
            addPlayingSoundView(for: soundName)
            addVolumeView(for: soundName)
            setupWaves(playingSounds.count)
        }
    }
    private func setupWaves(_ count : Int){
        waveView.setupWaves(count: count)
        waveView.startAnimation()
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
        let existingPlayerIndex = players.firstIndex(where: { player in
            if let player = player,
               let playerURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                return player.url == playerURL && player.isPlaying
            }
            return false
        })
        if existingPlayerIndex != nil {
            let alertController = AlertController(title: "The sound is already added.")
            alertController.presentAlert(from: self, duration: 1.0)
            return
        }
        if players.compactMap({ $0 }).count >= 5 {
            let alertController = AlertController(title: "Sorry! We can't add more sounds :(")
            alertController.presentAlert(from: self, duration: 1.5)
            return
        }
        guard let emptyIndex = players.firstIndex(where: { $0 == nil }) else {
            print("No available slots for new audio player")
            return
        }
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Audio file not found for option: \(soundName)")
            return
        }
        do {
            if isAlreadyFavorite {
                isAlreadyFavorite = false
                updateFavoriteButton(isFavorite: false)
                titleLabel.text = "Current Mix"
            }
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
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
    }
    private func moveToCollapsedPosition() {
        UIView.animate(withDuration: 0.3) {
            self.topConstraint.constant = self.collapsedTopConstant
            self.view.layoutIfNeeded()
        }
    }
    private func moveToOriginalPosition() {
        UIView.animate(withDuration: 0.3) {
            self.topConstraint.constant = self.originalTopConstant
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Selectors
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view).y // How far the user dragged
        let totalDraggableDistance = originalTopConstant - collapsedTopConstant // Total distance between positions

        switch gesture.state {
        case .changed:
            // Update the top constraint dynamically during drag
            let newConstant = max(collapsedTopConstant, min(originalTopConstant, topConstraint.constant + translation))
            topConstraint.constant = newConstant
            view.layoutIfNeeded() // Apply the layout changes
            gesture.setTranslation(.zero, in: view) // Reset translation to avoid cumulative effects

        case .ended:
            let dragPercentage = abs(topConstraint.constant - originalTopConstant) / totalDraggableDistance
            
            if dragPercentage >= 0.5 {
                if topConstraint.constant < originalTopConstant {
                    // User dragged upwards: move to collapsed position
                    moveToCollapsedPosition()
                } else {
                    // User dragged downwards: move to original position
                    moveToOriginalPosition()
                }
            } else {
                // Drag didn't exceed 50%, revert to the current position
                if topConstraint.constant == collapsedTopConstant {
                    moveToCollapsedPosition()
                } else {
                    moveToOriginalPosition()
                }
            }
        default:
            break
        }
    }
    @objc private func didTapFavouriteView() {
        guard titleLabel.text != nil else { return }
        
        if isAlreadyFavorite {
            guard let currentID = getCurrentLibraryItemID() else { return }
            //let alert = AlertController(title: "\(currentTitle) removed from favorites")
            LibraryManager.shared.removeFromLibrary(id: currentID)
            updateFavoriteButton(isFavorite: false)
            //alert.presentAlert(from: self)
        } else {
            let controller = RenamingViewController()
            controller.modalPresentationStyle = .overCurrentContext
            controller.delegate = self
            controller.initialValue = titleLabel.text
            self.present(controller, animated: false)
        }
    }
    @objc private func didChangeVolume(_ sender: UISlider) {
        let masterVolume = sender.value
        
        for (_, player) in players.enumerated() {
            guard let player = player,
                  let url = player.url,
                  let soundName = url.deletingPathExtension().lastPathComponent.lowercased() as String? else {
                continue
            }
            let individualVolume = individualVolumes[soundName] ?? 1.0
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
        setupWaves(playingSounds.count) // Updated Waves
    }
    @objc private func didTapDismissView() {
        dismiss(animated: false)
    }
}

// MARK: - For updation of value and adding it to the library
extension PlayViewController: ValuePassingDelegate {
    
    func didEnterValue(_ value: String) {
        let newLibraryItem = LibraryItems(
            title: value,
            icon: "favorite_library_icon",  //
            soundTypes: getCurrentPlayingSoundTypes()
        )
        
        let isDuplicate = LibraryManager.shared.addToLibrary(newLibraryItem)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let presentedVC = self.presentedViewController {
                presentedVC.dismiss(animated: true) {
                    //self.showAlert(isDuplicate: isDuplicate, title: newLibraryItem.title)
                }
            } else {
                //self.showAlert(isDuplicate: isDuplicate, title: newLibraryItem.title) // dummy, design discussion required
            }
            if !isDuplicate {
                titleLabel.text = value
                isAlreadyFavorite = true
                updateFavoriteButton(isFavorite: true)
            }
        }
    }
    private func showAlert(isDuplicate: Bool, title: String) {
        let message = isDuplicate ? "Same mix already exists.": "\(title) added to favorites"
        let alert = AlertController(title: message)
        alert.presentAlert(from: self, duration: 0.5)
    }
    private func updateFavoriteButton(isFavorite: Bool) {
        if isFavorite {
            favouriteImageView.image = UIImage(named: "favourite_done")
            isAlreadyFavorite = true
        } else {
            favouriteImageView.image = UIImage(named: "favourite")
            isAlreadyFavorite = false
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
