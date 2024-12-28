//
//  SoundCollectionViewCell.swift
//  ScreenTask
//
//  Created by Faisal Iqbal on 17/12/2024.
//
import UIKit

class SoundCollectionViewCell: CollectionViewCell {
    
    private let mainImageViewWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    private let mainImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    private let smallImageViewWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    private let smallImage1 = createSmallImageView()
    private let smallImage2 = createSmallImageView()
    private let smallImage3 = createSmallImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let actionButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .midnightPurple
        btn.layer.cornerRadius = 20.autoSized
        btn.setImage(UIImage(named: "play"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.layer.cornerRadius = 16
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(mainImageViewWrapper)
        mainImageViewWrapper.addSubview(mainImage)
        contentView.addSubview(smallImageViewWrapper)
        smallImageViewWrapper.addSubview(smallImage1)
        smallImageViewWrapper.addSubview(smallImage2)
        smallImageViewWrapper.addSubview(smallImage3)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            
            mainImageViewWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            mainImageViewWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            mainImageViewWrapper.widthAnchor.constraint(equalToConstant: 52),
            mainImageViewWrapper.heightAnchor.constraint(equalToConstant: 52),
            
            mainImage.topAnchor.constraint(equalTo: mainImageViewWrapper.topAnchor, constant: 10),
            mainImage.leadingAnchor.constraint(equalTo: mainImageViewWrapper.leadingAnchor, constant: 10),
            mainImage.trailingAnchor.constraint(equalTo: mainImageViewWrapper.trailingAnchor, constant: -10),
            mainImage.bottomAnchor.constraint(equalTo: mainImageViewWrapper.bottomAnchor, constant: -10),
            mainImage.widthAnchor.constraint(equalToConstant: 32),
            mainImage.heightAnchor.constraint(equalToConstant: 32),
           
            smallImageViewWrapper.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            smallImageViewWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            smallImageViewWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            smallImageViewWrapper.heightAnchor.constraint(equalToConstant: 24),
            //smallImageViewWrapper.widthAnchor.constraint(equalToConstant: 24),
            
            smallImage1.topAnchor.constraint(equalTo: smallImageViewWrapper.topAnchor, constant: 5),
            smallImage1.leadingAnchor.constraint(equalTo: smallImageViewWrapper.leadingAnchor, constant: 5),
            smallImage1.widthAnchor.constraint(equalToConstant: 14),
            smallImage1.heightAnchor.constraint(equalToConstant: 14),
            
            smallImage2.topAnchor.constraint(equalTo: smallImageViewWrapper.topAnchor, constant: 5),
            smallImage2.leadingAnchor.constraint(equalTo: smallImage1.trailingAnchor, constant: 5),
            smallImage2.widthAnchor.constraint(equalToConstant: 14),
            smallImage2.heightAnchor.constraint(equalToConstant: 14),
            
            smallImage3.topAnchor.constraint(equalTo: smallImageViewWrapper.topAnchor, constant: 5),
            smallImage3.leadingAnchor.constraint(equalTo: smallImage2.trailingAnchor, constant: 5),
            smallImage3.widthAnchor.constraint(equalToConstant: 14),
            smallImage3.heightAnchor.constraint(equalToConstant: 14),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageViewWrapper.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            
            actionButton.topAnchor.constraint(equalTo: smallImageViewWrapper.bottomAnchor, constant: 12),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    func configure(with item: SoundItems) {
        mainImage.image = item.mainImage
        smallImage1.image = item.smallImage1
        smallImage2.image = item.smallImage2
        smallImage3.image = item.smallImage3
        titleLabel.text = item.title
        mainImageViewWrapper.backgroundColor = item.mainBackgroundColor
        smallImage1.backgroundColor = item.smallBackgroundColor1
        smallImage2.backgroundColor = item.smallBackgroundColor2
        smallImage3.backgroundColor = item.smallBackgroundColor3
    }
    private static func createSmallImageView() -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }
}
