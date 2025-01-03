//
//  LibraryViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 01/01/2025.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // MARK: - UI Components
    private let searchBar = SearchBarView()
    private let titleLabel: Label = {
        let label = Label(text: "Library", textAlignment: .left, textColor: .titleColor)
        label.font = .bold(ofSize: 28.autoSized)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tintColor = .clear
        tableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.identifier)
        return tableView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.autoSized),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            searchBar.heightAnchor.constraint(equalToConstant: 56.autoSized),
        
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 32.autoSized),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
        
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.autoSized),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.autoSized)
        ])
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.identifier, for: indexPath) as! LibraryCell
        let soundTypes = [
            LibraryCell.SoundType(icon: "rain", tintColor: .blue),
            LibraryCell.SoundType(icon: "coffeeshop", tintColor: .brown),
            LibraryCell.SoundType(icon: "fire", tintColor: .orange),
            LibraryCell.SoundType(icon: "scuba", tintColor: .purple)
        ]
        cell.configure(
            with: "Rainy cafe",
            icon: "rainy_day",
            iconBackground: UIColor(red: 1, green: 0.9, blue: 0.9, alpha: 1), // Light pink
            soundTypes: soundTypes
        )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell at row \(indexPath.row+1) tapped")
    }
}
