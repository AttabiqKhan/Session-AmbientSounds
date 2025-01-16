//
//  SoundCollectionViewCell.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 14/01/2025.
//

import UIKit

class SoundsCollectionViewCell: CollectionViewCell {
    
    // MARK: - UI Components
    private let cellView = View(backgroundColor: .clear, cornerRadius: 25.autoSized)
    private let iconImageView = ImageView(imageName: "rain", cornerRadius: 25.autoSized, backgroundColor: .clear)
    private let imageName: Label = {
        let label = Label(text: "test")
        label.font = .medium(ofSize: 13.autoSized)
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        self.backgroundColor = .clear
        self.layer.cornerRadius = 37.autoSized
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupCell(){
        contentView.addSubview(cellView)
        cellView.addSubview(iconImageView)
        cellView.addSubview(imageName)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 73.autoSized),
            cellView.widthAnchor.constraint(equalToConstant: 73.autoSized),
            
            iconImageView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24.autoSized),
            iconImageView.widthAnchor.constraint(equalToConstant: 24.autoSized),
            
            imageName.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 8.autoSized),
            imageName.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            imageName.heightAnchor.constraint(equalToConstant: 13.autoSized)
        ])
    }
    func configure(with item: SoundItem) {
        iconImageView.image = item.icon
        imageName.text = item.name
        cellView.backgroundColor = item.backgroundColor
        cellView.layer.cornerRadius = 37.autoSized
        cellView.layer.borderColor =  UIColor.black.withAlphaComponent(0.03).cgColor
        cellView.layer.borderWidth = 2.autoSized
    }
}

