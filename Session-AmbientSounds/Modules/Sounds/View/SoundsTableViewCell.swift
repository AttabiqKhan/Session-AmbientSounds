//
//  SoundsTableViewCell.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 14/01/2025.
//

import UIKit

protocol SoundTableViewCellDelegate: AnyObject {
    func didSelectItem(named name: String)
}

class SoundTableViewCell: TableViewCell {
    
    // MARK: - UI Components
    var headingLabel: Label = {
        let label = Label(text: "--")
        label.font = .bold(ofSize: 28.autoSized)
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16.autoSized
        layout.minimumInteritemSpacing = 16.widthRatio
        layout.itemSize = CGSize(width: 73.widthRatio, height: 94.autoSized)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(SoundsCollectionViewCell.self, forCellWithReuseIdentifier: SoundsCollectionViewCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.isUserInteractionEnabled = true
        cv.allowsSelection = true
        return cv
    }()
    
    // MARK: - Properties
    private var items: [SoundItem] = []
    weak var delegate: SoundTableViewCellDelegate?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupCell(){
        contentView.addSubview(headingLabel)
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.autoSized),
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor,constant: 24.autoSized),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    func configure(with items: [SoundItem]) {
        self.items = items
        collectionView.reloadData()
    }
}

// MARK: - Collection View Delegate & Data Source
extension SoundTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundsCollectionViewCell.identifier, for: indexPath) as? SoundsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: items[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = items[indexPath.item].name
        let sanitizedName = name.lowercased().replacingOccurrences(of: " ", with: "")
        delegate?.didSelectItem(named: sanitizedName)
    }
}
