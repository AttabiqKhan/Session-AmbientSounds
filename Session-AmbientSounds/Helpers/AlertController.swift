//
//  AlertController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 17/12/2024.
//

import UIKit

class AlertController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = View(backgroundColor: .lavenderMist, cornerRadius: 8.autoSized)
    private let titleLabel = Label(text: "", textColor: .white)
    
    // MARK: - Initializers
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.autoSized),
            containerView.heightAnchor.constraint(equalToConstant: 48.autoSized),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53.widthRatio),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -53.widthRatio),
        
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    func presentAlert(from viewController: UIViewController, duration: TimeInterval = 1.0) {
        viewController.present(self, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.dismiss(animated: true)
            }
        }
    }
}
