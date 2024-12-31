//
//  BottomCollectionViewCell.swift
//  ScreenTask
//
//  Created by Faisal Iqbal on 18/12/2024.
//

import UIKit

class BottomCollectionViewCell: CollectionViewCell {

    private let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 12.autoSized
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(ofSize: 13.autoSized)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.layer.cornerRadius = 36.autoSized
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25.autoSized),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.widthRatio),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.widthRatio),
            imageView.heightAnchor.constraint(equalToConstant: 24.autoSized),
           
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8.autoSized)
        ])
    }
    func configure(with item: BottomItem) {
        imageView.image = item.image
        titleLabel.text = item.label
        contentView.backgroundColor = item.backgroundColor
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
        contentView.layer.borderWidth = 2
    }
}



