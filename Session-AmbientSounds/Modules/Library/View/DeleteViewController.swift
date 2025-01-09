//
//  DeleteViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 08/01/2025.
//

import UIKit

class DeleteViewController: UIViewController {
    
    // MARK: - UI Components
    private let containerView = View(backgroundColor: .white)
    private let lineView = View(backgroundColor: .lineColor, cornerRadius: 2.5)
    private let titleLabel: Label = {
        let label = Label(text: "Are you sure you want to remove this mix from your library?", textAlignment: .center, numberOfLines: 0, textColor: .titleColor)
        label.font = .medium(ofSize: 16.autoSized)
        return label
    }()
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonSecondaryColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32.autoSized
        button.setTitle("Remove", for: .normal)
        button.titleLabel?.font = .semiBold(ofSize: 16.autoSized)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: LibraryManagementDelegate?
    var mixId: String?
    var mixTitle: String?
    private var presentationHelper: PresentationHelper!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationHelper = PresentationHelper(containerView: containerView, viewController: self)
        setupUI()
        updateTitle()
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 40.autoSized
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let panGesture = UIPanGestureRecognizer(target: presentationHelper, action: #selector(presentationHelper.handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
        
        view.addSubview(containerView)
        containerView.addSubview(lineView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lineView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.autoSized),
            lineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            lineView.heightAnchor.constraint(equalToConstant: 5.autoSized),
            
            titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32.autoSized),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 47.widthRatio),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -47.widthRatio),
            
            removeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.autoSized),
            removeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            removeButton.heightAnchor.constraint(equalToConstant: 64.autoSized),
            removeButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -40.autoSized)
        ])
    }
    private func updateTitle() {
        guard let title = mixTitle else { return }
        
        let baseText = "Are you sure you want to remove \(title) from your library?"
        let attributedString = NSMutableAttributedString(string: baseText)
        
        if let titleRange = baseText.range(of: title) {
            let nsRange = NSRange(titleRange, in: baseText)
            
            attributedString.replaceCharacters(in: nsRange, with: "“\(title)”")
            
            if let quotedTitleRange = attributedString.string.range(of: "“\(title)”") {
                let quotedNSRange = NSRange(quotedTitleRange, in: attributedString.string)
                
                attributedString.addAttributes(
                    [
                        .font: UIFont.bold(ofSize: 16.autoSized),
                        .foregroundColor: UIColor.titleColor
                    ],
                    range: quotedNSRange
                )
            }
        }
        titleLabel.attributedText = attributedString
    }
    
    // MARK: - Selectors
    @objc private func removeButtonTapped() {
        guard let id = mixId else { return }
        LibraryManager.shared.removeFromLibrary(id: id)
        delegate?.didDeleteItem(id: id)
        dismiss(animated: false)
    }
}
