//
//  LibraryManagementCell.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 06/01/2025.
//

import UIKit

class LibraryManagementCell: TableViewCell {
    
    // MARK: - UI Components
    private let container = View(backgroundColor: .white)
    private let optionImageView: ImageView = {
        let iv = ImageView(imageName: "like")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let optionLabel: Label = {
        let label = Label(text: "Some text", textAlignment: .left, numberOfLines: 1, textColor: .titleColor)
        label.font = .medium(ofSize: 16.autoSized)
        return label
    }()
    
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
        self.selectionStyle = .none
        contentView.addSubview(container)
        container.addSubview(optionImageView)
        container.addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            optionImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            optionImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.autoSized),
            optionImageView.heightAnchor.constraint(equalToConstant: 24.autoSized),
            optionImageView.widthAnchor.constraint(equalToConstant: 24.autoSized),

            optionLabel.leadingAnchor.constraint(equalTo: optionImageView.trailingAnchor, constant: 16.widthRatio),
            optionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.autoSized),
            optionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            optionLabel.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -16.autoSized),
        ])
    }
    func configure(with image: String, title: String) {
        optionImageView.image = UIImage(named: image)
        optionLabel.text = title
    }
}
