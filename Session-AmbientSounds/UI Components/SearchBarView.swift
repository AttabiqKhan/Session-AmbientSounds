//
//  SearchBarView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 01/01/2025.
//

import UIKit

protocol SearchBarViewDelegate: AnyObject {
    func searchBar(_ searchBar: SearchBarView, didUpdateSearchText text: String)
}

class SearchBarView: UIView {
    
    // MARK: - UI Components
    private let searchImage: ImageView = {
        let imageView = ImageView(imageName: "search")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let searchTextField: TextField = {
        let tf = TextField(borderStyle: .none, placeHolder: "")
        tf.backgroundColor = .tertiary
        tf.textColor = .titleColor
        tf.layer.cornerRadius = 24.autoSized
        tf.layer.borderColor = UIColor.searchBorderColor.cgColor
        tf.layer.borderWidth = 1.0
        return tf
    }()
    private let placeholderLabel: Label = {
        let label = Label(text: "Search", textColor: .neutralGray)
        label.font = .medium(ofSize: 16.autoSized)
        return label
    }()
    private let clearButton: Button = {
        let button = Button(image: UIImage(named: "cancel"), tintColor: .gray)
        button.isHidden = true
        return button
    }()

    // MARK: - Properties
    private var searchImageCenterConstraint: NSLayoutConstraint?
    private var searchImageLeadingConstraint: NSLayoutConstraint?
    private var textFieldLeadingConstraint: NSLayoutConstraint?
    private var textFieldTrailingConstraint: NSLayoutConstraint?
    private var isSearchActive = false
    private var originalPlaceholderCenter: CGPoint?
    weak var delegate: SearchBarViewDelegate?
    private var searchText: String = "" {
        didSet {
            delegate?.searchBar(self, didUpdateSearchText: searchText)
        }
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupUI()
        setupTargets()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupUI() {
        self.layer.cornerRadius = 24.autoSized
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(searchTextField)
        self.addSubview(searchImage)
        self.addSubview(clearButton)
        self.addSubview(placeholderLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        textFieldTrailingConstraint = searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        searchImageCenterConstraint = searchImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30.widthRatio)
        searchImageLeadingConstraint = searchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.widthRatio)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldTrailingConstraint!,
            
            clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 24.autoSized),
            clearButton.heightAnchor.constraint(equalToConstant: 24.autoSized),
            
            placeholderLabel.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 12.autoSized),
            placeholderLabel.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            
            searchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 24.widthRatio),
            searchImage.heightAnchor.constraint(equalToConstant: 24.autoSized),
            searchImageCenterConstraint!
        ])
        searchImageLeadingConstraint?.isActive = false
        
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 52.widthRatio, height: 1))
        searchTextField.leftViewMode = .always
    }
    private func setupTargets() {
        searchTextField.delegate = self
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    private func animateToActiveState() {
        searchImageCenterConstraint?.isActive = false
        searchImageLeadingConstraint?.isActive = true
        textFieldTrailingConstraint?.isActive = false
        textFieldTrailingConstraint = searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40.widthRatio)
        textFieldTrailingConstraint?.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 0
            self.clearButton.isHidden = false
            self.layoutIfNeeded()
        }
    }
    private func animateToInactiveState() {
        searchImageLeadingConstraint?.isActive = false
        searchImageCenterConstraint?.isActive = true
        textFieldTrailingConstraint?.isActive = false
        textFieldTrailingConstraint = searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        textFieldTrailingConstraint?.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 1
            self.clearButton.isHidden = true
            self.layoutIfNeeded()
        }
    }
    func getCurrentSearchText() -> String {
        return searchText
    }
    
    // MARK: - Selectors
    @objc private func clearButtonTapped() {
        searchTextField.text = ""
        searchText = ""
        clearButton.isHidden = true
        if !searchTextField.isFirstResponder {
            animateToInactiveState()
        }
    }
    @objc private func textFieldDidChange() {
        searchText = searchTextField.text ?? ""
    }
}

// MARK: - TextField Delegate
extension SearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSearchActive = true
        animateToActiveState()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSearchActive = false
        if textField.text?.isEmpty ?? true {
            animateToInactiveState()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
