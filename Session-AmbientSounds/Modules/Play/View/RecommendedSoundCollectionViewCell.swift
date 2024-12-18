//
//  RecommendedSoundCollectionViewCell.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 15/12/2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

class RecommendedSoundCollectionViewCell: CollectionViewCell {
    
    private let containerView : View = {
        let view = View(cornerRadius: 37.autoSized)
        view.layer.borderColor =  UIColor.black.withAlphaComponent(0.03).cgColor
        view.layer.borderWidth = 2.autoSized
        return view
    }()
    private let iconImageView = ImageView(imageName: "rain", cornerRadius: 12.autoSized, backgroundColor: .clear)
    private let imageName: Label = {
        let label = Label(text: "test", textAlignment: .center)
        label.font = .medium(ofSize: 13.autoSized)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 37.autoSized
        setUpView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        self.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(imageName)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 73.autoSized),
            containerView.widthAnchor.constraint(equalToConstant: 73.autoSized),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24.autoSized),
            iconImageView.widthAnchor.constraint(equalToConstant: 24.autoSized),
            
            imageName.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8.autoSized),
            imageName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    func configure(with item: SoundItem) {
        iconImageView.image = item.icon
        imageName.text = item.name
        containerView.backgroundColor = item.backgroundColor
    }
}
