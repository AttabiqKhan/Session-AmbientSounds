//
//  HomeViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 16/11/2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - UI Elements
    private let headingLabel: Label = {
        let label = Label(text: "Based on\nyour mood", textAlignment: .left, numberOfLines: 0, textColor: .black)
        label.font = .bold(ofSize: 28.autoSized)
        return label
    }()
    private let emojiView = View(backgroundColor: .emojiBackground, cornerRadius: 24.autoSized)
    private let emoji: Label = {
        let label = Label(text: "🙂")
        label.font = .poppinsMedium(ofSize: 32)
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: MoodCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Functions
    override func setupViews() {
        super.setupViews()
        view.addSubview(headingLabel)
        view.addSubview(emojiView)
        emojiView.addSubview(emoji)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 83.autoSized),
            
            emojiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 79.autoSized),
            emojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            emojiView.heightAnchor.constraint(equalToConstant: 64.autoSized),
            emojiView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            
            emoji.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 28.autoSized),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            //collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.autoSized)
        ])
        emojiView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEmojiView)))
    }
    
    // MARK: - Selectors
    @objc private func didTapEmojiView() {
        let controller = PlayViewController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionViewCell.identifier, for: indexPath) as! MoodCollectionViewCell
        cell.backgroundColor = .midnightPurple
        return cell
    }
}
