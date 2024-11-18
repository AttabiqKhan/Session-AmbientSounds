//
//  OnboardingCell.swift
//  DummyOnboarding
//
//  Created by Attabiq Khan on 04/11/2024.
//

import Foundation
import UIKit

class OnboardingCell: UICollectionViewCell {
        
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPurple
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .extraBold(ofSize: 40.autoSized)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .titleColor
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(ofSize: 16.autoSized)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .subtitleColor
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden Functions
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: - Functions
    private func setupUI() {
        [imageView, titleLabel, subtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 131.autoSized),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 212.widthRatio),
            imageView.heightAnchor.constraint(equalToConstant: 272.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24.autoSized),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.widthRatio),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.widthRatio),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.autoSized),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60.widthRatio),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60.widthRatio),
        ])
    }
    func configure(with item: OnboardingItem) {
        imageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
