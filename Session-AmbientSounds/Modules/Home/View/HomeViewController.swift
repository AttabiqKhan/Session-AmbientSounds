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
        layout.itemSize = CGSize(width: 162.autoSized, height: 200.autoSized)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SoundCollectionViewCell.self, forCellWithReuseIdentifier: SoundCollectionViewCell.identifier)
        return collectionView
    }()
    private lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 73.autoSized, height: 73.autoSized)
        layout.minimumLineSpacing = 37
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCollectionViewCell.identifier)
        return collectionView
    }()
    private let soundItems: [SoundItems] = [
        SoundItems(mainImage: UIImage(named: "stress_relief")!,
                  smallImage1: UIImage(named: "rain")!,
                  smallImage2: UIImage(named: "waves")!,
                  smallImage3: UIImage(named: "fire")!,
                  title: "Stress relief",
                  mainBackgroundColor: .mainBackgroundColor,
                  smallBackgroundColor1: .rainColor,
                  smallBackgroundColor2: .wavesColor,
                  smallBackgroundColor3: .fireColor),
        SoundItems(mainImage: UIImage(named: "rainy_day")!,
                  smallImage1: UIImage(named: "rain")!,
                  smallImage2: UIImage(named: "forest")!,
                  smallImage3: UIImage(named: "birds")!,
                  title: "Rainy day",
                  mainBackgroundColor: .mainBackgroundColor,
                  smallBackgroundColor1: .rainColor,
                  smallBackgroundColor2: .forestColor,
                  smallBackgroundColor3: .birdsColor),
        SoundItems(mainImage: UIImage(named: "cozy_fire")!,
                  smallImage1: UIImage(named: "fire")!,
                  smallImage2: UIImage(named: "wind")!,
                  smallImage3: UIImage(named: "thunder")!,
                  title: "Cozy fire",
                  mainBackgroundColor: .mainBackgroundColor,
                  smallBackgroundColor1: .fireColor,
                  smallBackgroundColor2: .windColor,
                  smallBackgroundColor3: .thunderColor),
        SoundItems(mainImage: UIImage(named: "intimate_night")!,
                  smallImage1: UIImage(named: "guitar")!,
                  smallImage2: UIImage(named: "waves")!,
                  smallImage3: UIImage(named: "piano")!,
                  title: "Intimate night",
                  mainBackgroundColor: .mainBackgroundColor,
                  smallBackgroundColor1: .guitarColor,
                  smallBackgroundColor2: .wavesColor,
                  smallBackgroundColor3: .pianoColor)
    ]
    private let bottomItems: [BottomItem] = [
        BottomItem(image: UIImage(named: "piano")!, label: "Piano", backgroundColor: .pianoColor),
        BottomItem(image: UIImage(named: "rain")!, label: "Rain", backgroundColor: .rainColor),
        BottomItem(image: UIImage(named: "guitar")!, label: "Guitar", backgroundColor: .guitarColor),
        BottomItem(image: UIImage(named: "wind")!, label: "Wind", backgroundColor: .windColor),
        BottomItem(image: UIImage(named: "fire")!, label: "Fire", backgroundColor: .fireColor),
        BottomItem(image: UIImage(named: "waves")!, label: "Waves", backgroundColor: .wavesColor),
        BottomItem(image: UIImage(named: "thunder")!, label: "Thunder", backgroundColor: .thunderColor),
        BottomItem(image: UIImage(named: "scuba")!, label: "Scuba", backgroundColor: .scubaColor),
        BottomItem(image: UIImage(named: "droplets")!, label: "Droplets", backgroundColor: .dropletsColor),
        BottomItem(image: UIImage(named: "coffeeshop")!, label: "Coffee Shop", backgroundColor: .coffeeColor),
        BottomItem(image: UIImage(named: "forest")!, label: "Forest", backgroundColor: .forestColor),
        BottomItem(image: UIImage(named: "birds")!, label: "Birds", backgroundColor: .birdsColor)
    ]
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended sounds"
        label.font = .bold(ofSize: 28.autoSized)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    // MARK: - Functions
    override func setupViews() {
        super.setupViews()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomCollectionView)
        contentView.addSubview(headingLabel)
        contentView.addSubview(emojiView)
        emojiView.addSubview(emoji)
        
        NSLayoutConstraint.activate([
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.widthRatio),
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36.autoSized),
            
            emojiView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36.autoSized),
            emojiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.widthRatio),
            emojiView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            emojiView.heightAnchor.constraint(equalTo: emojiView.widthAnchor),
            
            emoji.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomTabBar.topAnchor, constant: -10.autoSized),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            collectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 28.autoSized),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.widthRatio),

            descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32.autoSized),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.widthRatio),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.widthRatio),

            bottomCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24.autoSized),
            bottomCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.widthRatio),
            bottomCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.widthRatio),
            bottomCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.autoSized)
    
        ])
        emojiView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEmojiView)))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustCollectionViewHeight()
        adjustBottomCollectionViewHeight()
    }
    
    // MARK: - Functions
    private func adjustCollectionViewHeight() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let rows = ceil(Double(soundItems.count) / 2.0)
            let height = rows * Double(layout.itemSize.height + layout.minimumLineSpacing) - layout.minimumLineSpacing
            collectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
    }
    private func adjustBottomCollectionViewHeight() {
        if let layout = bottomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let rows = ceil(Double(bottomItems.count) / 3.0)
            let height = rows * Double(layout.itemSize.height + layout.minimumLineSpacing) - layout.minimumLineSpacing
            bottomCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapEmojiView() {
//        let controller = MoodViewController()
//        controller.modalPresentationStyle = .overCurrentContext
//        self.present(controller, animated: false)
        let controller = LibraryViewController()
        self.navigationController?.pushViewController(controller, animated: false)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return soundItems.count
        } else {
            return bottomItems.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCollectionViewCell.identifier, for: indexPath) as! SoundCollectionViewCell
            let item = soundItems[indexPath.row]
            cell.configure(with: item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.identifier, for: indexPath) as! BottomCollectionViewCell
            let item = bottomItems[indexPath.row]
            cell.configure(with: item)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.bottomCollectionView {
            let soundName = bottomItems[indexPath.item].label.lowercased().replacingOccurrences(of: " ", with: "")
            let vc = PlayViewController(initialSoundTitle: soundName)
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false)
        }
    }
}
