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
        tableView.tintColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.identifier)
        return tableView
    }()
    
    // MARK: - Properties
    //private var libraryData = LibraryData.data
    private var libraryData: [LibraryItems] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        LibraryManager.shared.delegate = self
        updateLibraryData()
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dummySearch))) // need to remove this after the implementation
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
    private func updateLibraryData() {
        libraryData = LibraryManager.shared.getLibraryItems()
        tableView.reloadData()
    }
    
    @objc private func dummySearch() {
        navigationController?.popViewController(animated: false)
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.identifier, for: indexPath) as! LibraryCell
        let data = libraryData[indexPath.row]
           cell.configure(
               with: data.title,
               icon: data.icon,
               iconBackground: .mainBackgroundColor,
               soundTypes: data.soundTypes
           )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell at row \(indexPath.row+1) tapped") // need to remove this after the implementation
    }
}

// MARK: - Updating of Data
extension LibraryViewController: LibraryManagerDelegate {
    func libraryDidUpdate() {
        updateLibraryData()
    }
}
