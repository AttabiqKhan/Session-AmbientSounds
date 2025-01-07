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
    
    struct SoundType: Equatable, Codable {
        let icon: String
    }
    
    // MARK: - UI Components
    private let container: View = {
        let view =  View(backgroundColor: .lightGrayBackground, cornerRadius: 16.autoSized)
        view.layer.borderColor = UIColor.lineColor.cgColor
        view.layer.borderWidth = 0.5
        view.tintColor = .clear
        return view
    }()
    private let iconContainer = View(cornerRadius: 16.autoSized)
    private let iconImageView: ImageView = {
        let imageView = ImageView(imageName: "favorite_library_icon")
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
    private let overflowLabel: Label = {
        let label = Label(text: "+1", textColor: .titleColor)
        label.font = .medium(ofSize: 13.autoSized)
        return label
    }()
    private var soundTypeViews: [View] = []
    
    // MARK: - Properties
    private let maxVisibleSoundTypes = 3
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.autoSized),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            iconContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.widthRatio),
            iconContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 52.autoSized),
            iconContainer.heightAnchor.constraint(equalToConstant: 52.autoSized),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32.autoSized),
            iconImageView.heightAnchor.constraint(equalToConstant: 32.autoSized),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16.widthRatio),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17.autoSized),
            
            stackView.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16.widthRatio),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.autoSized),
            stackView.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -12.widthRatio),
            stackView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor),
            
            moreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.widthRatio),
            moreButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 24.autoSized),
            moreButton.heightAnchor.constraint(equalToConstant: 24.autoSized)
        ])
    }
    func configure(with title: String, icon: String, iconBackground: UIColor, soundTypes: [SoundType]) {
        titleLabel.text = title
        iconImageView.image = UIImage(named: icon)
        iconContainer.backgroundColor = iconBackground
        
        soundTypeViews.forEach { $0.removeFromSuperview() }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        soundTypeViews.removeAll()
        
        let visibleCount = min(soundTypes.count, maxVisibleSoundTypes)
        for i in 0..<visibleCount {
            let soundType = soundTypes[i]
            let typeView = createSoundTypeView(icon: soundType.icon)
            stackView.addArrangedSubview(typeView)
            soundTypeViews.append(typeView)
            stackView.addArrangedSubview(overflowLabel)
        }
        if soundTypes.count > maxVisibleSoundTypes {
            overflowLabel.text = "+\(soundTypes.count - maxVisibleSoundTypes)"
        }
        else {
            overflowLabel.alpha = 0
        }
    }
    private func createSoundTypeView(icon: String) -> View {
        let container = View(backgroundColor: colorForSoundName(icon), cornerRadius: 12.autoSized)
        container.layer.borderWidth = 1.0
        container.layer.borderColor = UIColor.sliderContainerColor.cgColor
        
        let imageView = ImageView(imageName: icon)
        imageView.contentMode = .scaleAspectFit
        
        container.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 24.autoSized),
            container.heightAnchor.constraint(equalToConstant: 24.autoSized),
            
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 14.autoSized),
            imageView.heightAnchor.constraint(equalToConstant: 14.autoSized)
        ])
        return container
    }
}
