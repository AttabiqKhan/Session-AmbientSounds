//
//  RenamingViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 29/11/2024.
//

import UIKit

protocol ValuePassingDelegate: AnyObject {
    func didEnterValue(_ value: String)
}

class RenamingViewController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = View(backgroundColor: .white)
    private let lineView = View(backgroundColor: .lineColor, cornerRadius: 2.5)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name your mix"
        label.textAlignment = .center
        label.textColor = .titleColor
        label.font = .bold(ofSize: 28.autoSized)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let textField: TextField = {
        let tf = TextField(borderStyle: .roundedRect, placeHolder: "My Mix")
        tf.font = .medium(ofSize: 19.autoSized)
        tf.textAlignment = .left
        return tf
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonSecondaryColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32.autoSized
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Figtree-SemiBold", size: 16.autoSized)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: ValuePassingDelegate?
    var initialValue: String? // Property to store the updated value
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.addSubview(containerView)
        [lineView, titleLabel, textField, doneButton].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lineView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.autoSized),
            lineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            lineView.heightAnchor.constraint(equalToConstant: 5.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32.autoSized),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.autoSized),
            textField.heightAnchor.constraint(equalToConstant: 56.autoSized),
            
            doneButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32.autoSized),
            doneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 64.autoSized),
            doneButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -40.autoSized)
        ])
        if let value = initialValue {
            textField.placeholder = value
        }
    }
    
    // MARK: - Selectors
    @objc private func doneButtonTapped() {
        guard let text = textField.text else { return }
        delegate?.didEnterValue(text)
        dismiss(animated: true, completion: nil)
    }
}
