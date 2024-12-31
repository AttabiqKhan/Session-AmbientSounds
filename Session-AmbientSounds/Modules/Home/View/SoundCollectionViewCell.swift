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
        view.layer.cornerRadius = 26.autoSized
        view.layer.masksToBounds = true
        return view
    }()
    private let mainImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
//    private let smallImageViewWrapper: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 12
//        view.layer.masksToBounds = true
//        return view
//    }()
    private let smallImageView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.autoSized
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let smallImageView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.autoSized
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let smallImageView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.autoSized
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let smallImage1: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let smallImage2: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let smallImage3: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
//    private let smallImage1 = createSmallImageView()
//    private let smallImage2 = createSmallImageView()
//    private let smallImage3 = createSmallImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(ofSize: 19.autoSized)
        label.textColor = .titleColor
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
        contentView.layer.cornerRadius = 16.autoSized
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(mainImageViewWrapper)
        mainImageViewWrapper.addSubview(mainImage)
        contentView.addSubview(smallImageView1)
        contentView.addSubview(smallImageView2)
        contentView.addSubview(smallImageView3)
        smallImageView1.addSubview(smallImage1)
        smallImageView2.addSubview(smallImage2)
        smallImageView3.addSubview(smallImage3)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            
            mainImageViewWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17.autoSized),
            mainImageViewWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17.widthRatio),
            mainImageViewWrapper.widthAnchor.constraint(equalToConstant: 52.autoSized),
            mainImageViewWrapper.heightAnchor.constraint(equalToConstant: 52.autoSized),
            
            mainImage.topAnchor.constraint(equalTo: mainImageViewWrapper.topAnchor, constant: 10.autoSized),
            mainImage.leadingAnchor.constraint(equalTo: mainImageViewWrapper.leadingAnchor, constant: 10.widthRatio),
            mainImage.trailingAnchor.constraint(equalTo: mainImageViewWrapper.trailingAnchor, constant: -10.widthRatio),
            mainImage.heightAnchor.constraint(equalToConstant: 32.autoSized),
           
            smallImageView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.autoSized),
            smallImageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17.widthRatio),
            smallImageView1.widthAnchor.constraint(equalToConstant: 24.autoSized),
            smallImageView1.heightAnchor.constraint(equalToConstant: 24.autoSized),
            
            smallImage1.topAnchor.constraint(equalTo: smallImageView1.topAnchor, constant: 5.autoSized),
            smallImage1.leadingAnchor.constraint(equalTo: smallImageView1.leadingAnchor, constant: 5.widthRatio),
            smallImage1.widthAnchor.constraint(equalToConstant: 14.autoSized),
            smallImage1.heightAnchor.constraint(equalToConstant: 14.autoSized),
            
            smallImageView2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.autoSized),
            smallImageView2.leadingAnchor.constraint(equalTo: smallImageView1.trailingAnchor, constant: 5.widthRatio),
            smallImageView2.widthAnchor.constraint(equalToConstant: 24.autoSized),
            smallImageView2.heightAnchor.constraint(equalToConstant: 24.autoSized),
            
            smallImage2.topAnchor.constraint(equalTo: smallImageView2.topAnchor, constant: 5.autoSized),
            smallImage2.leadingAnchor.constraint(equalTo: smallImageView2.leadingAnchor, constant: 5.widthRatio),
            smallImage2.widthAnchor.constraint(equalToConstant: 14.autoSized),
            smallImage2.heightAnchor.constraint(equalToConstant: 14.autoSized),
            
            smallImageView3.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.autoSized),
            smallImageView3.leadingAnchor.constraint(equalTo: smallImageView2.trailingAnchor, constant: 5.widthRatio),
            smallImageView3.widthAnchor.constraint(equalToConstant: 24.autoSized),
            smallImageView3.heightAnchor.constraint(equalToConstant: 24.autoSized),
            
            smallImage3.topAnchor.constraint(equalTo: smallImageView3.topAnchor, constant: 5.autoSized),
            smallImage3.leadingAnchor.constraint(equalTo: smallImageView3.leadingAnchor, constant: 5.widthRatio),
            smallImage3.widthAnchor.constraint(equalToConstant: 14.autoSized),
            smallImage3.heightAnchor.constraint(equalToConstant: 14.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageViewWrapper.bottomAnchor, constant: 4.autoSized),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17.widthRatio),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17.widthRatio),
            
            actionButton.topAnchor.constraint(equalTo: smallImageView1.bottomAnchor, constant: 12.autoSized),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17.widthRatio),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17.autoSized),
            actionButton.heightAnchor.constraint(equalToConstant: 40.autoSized),
            actionButton.widthAnchor.constraint(equalToConstant: 40.autoSized),
        ])
    }
    func configure(with item: SoundItems) {
        mainImage.image = item.mainImage
        smallImage1.image = item.smallImage1
        smallImage2.image = item.smallImage2
        smallImage3.image = item.smallImage3
        titleLabel.text = item.title
        mainImageViewWrapper.backgroundColor = item.mainBackgroundColor
        smallImageView1.backgroundColor = item.smallBackgroundColor1
        smallImageView2.backgroundColor = item.smallBackgroundColor2
        smallImageView3.backgroundColor = item.smallBackgroundColor3
        smallImageView1.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
        smallImageView1.layer.borderWidth = 2
        smallImageView2.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
        smallImageView2.layer.borderWidth = 2
        smallImageView3.layer.borderColor = UIColor.black.withAlphaComponent(0.03).cgColor
        smallImageView3.layer.borderWidth = 2
    }
//    private static func createSmallImageView() -> UIImageView {
//        let img = UIImageView()
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.contentMode = .scaleAspectFill
//        return img
//    }
}
