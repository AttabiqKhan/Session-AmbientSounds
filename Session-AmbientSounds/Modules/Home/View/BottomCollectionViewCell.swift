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
        img.layer.cornerRadius = 12
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.layer.cornerRadius = 36
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8) 
        ])
    }
    func configure(with item: BottomItem) {
        imageView.image = item.image
        titleLabel.text = item.label
        contentView.backgroundColor = item.backgroundColor
    }
}



