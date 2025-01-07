//
//  LibraryManagementPopupController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 06/01/2025.
//

import Foundation
import UIKit

class LibraryManagementPopupController: UIViewController {
    
    // MARK: - Variables
    private let containerView = View(backgroundColor: .white)
    private let lineView = View(backgroundColor: .lineColor, cornerRadius: 2.5)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tintColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LibraryManagementCell.self, forCellReuseIdentifier: LibraryManagementCell.identifier)
        return tableView
    }()
    
    // MARK: - Properties
    private var presentationHelper: PresentationHelper!
    private let libraryManagementData: [LibraryManagementData] = [
        LibraryManagementData(
            icon: "like",
            title: "Remove from library"
        ),
        LibraryManagementData(
            icon: "rename",
            title: "Rename mix"
        )
    ]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationHelper = PresentationHelper(containerView: containerView, viewController: self)
        setupUI()
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
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lineView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.autoSized),
            lineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 64.autoSized),
            lineView.heightAnchor.constraint(equalToConstant: 5.autoSized),
            
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32.autoSized),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25.widthRatio),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.widthRatio),
            tableView.heightAnchor.constraint(equalToConstant: 112.autoSized),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48.autoSized)
        ])
    }
//    func showPresentation() {
//        presentationHelper.presentSelf()
//    }
//    
//    func dismissPresentation() {
//        presentationHelper.dismissSelf()
//    }
}

extension LibraryManagementPopupController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryManagementData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryManagementCell.identifier, for: indexPath) as! LibraryManagementCell
        let data = libraryManagementData[indexPath.row]
        cell.configure(with: data.icon, title: data.title)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
