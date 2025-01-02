//
//  LibraryCell.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 02/01/2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

class LibraryCell: TableViewCell {
    
    // MARK: - UI Components
    private let container: View = {
        let view =  View(backgroundColor: .lightGrayBackground, cornerRadius: 16.autoSized)
        view.layer.borderColor = UIColor.lineColor.cgColor
        view.layer.borderWidth = 0.5
        view.tintColor = .clear
        return view
    }()
    private let iconContainer = View(cornerRadius: 26.autoSized)
    private let iconImageView: ImageView = {
        let imageView = ImageView(imageName: "cozy_fire")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titleLabel: Label = {
        let label = Label(text: "Title", textColor: .titleColor)
        label.font = .semiBold(ofSize: 16.autoSized)
        return label
    }()
    private let moreButton = Button(image: UIImage(named: "menu"), tintColor: .clear)
    private let stackView = StackView(axis: .horizontal, spacing: 4.autoSized, alignment: .fill, distribution: .fill)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        contentView.addSubview(container)
        container.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        container.addSubview(titleLabel)
        container.addSubview(stackView)
        container.addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.autoSized),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.widthRatio),
            iconContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 52.autoSized),
            iconContainer.heightAnchor.constraint(equalToConstant: 52.autoSized),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32.autoSized),
            iconImageView.heightAnchor.constraint(equalToConstant: 32.autoSized),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16.widthRatio),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.autoSized),
            
            stackView.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16.widthRatio),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.autoSized),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: moreButton.leadingAnchor, constant: -12.widthRatio),
            
            moreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.widthRatio),
            moreButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 24.autoSized),
            moreButton.heightAnchor.constraint(equalToConstant: 24.autoSized)
        ])
    }
}

