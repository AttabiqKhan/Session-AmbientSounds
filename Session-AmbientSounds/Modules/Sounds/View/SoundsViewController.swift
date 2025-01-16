//
//  SoundsViewController.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 14/01/2025.
//

import UIKit

class SoundsViewController: BaseViewController {
    
    // MARK: - UI Components
    private let searchBar = SearchBarView()
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.delegate = self
        tv.dataSource = self
        tv.register(SoundTableViewCell.self, forCellReuseIdentifier: SoundTableViewCell.identifier)
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.allowsSelection = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Properties
    private var soundCategories: [SoundCategory] = SoundDataProvider.getSoundCategories()
    
    // MARK: - Initializers
    init() {
        super.init(initialTab: .sounds)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Functions
    override func setupViews() {
        super.setupViews()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.autoSized),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            searchBar.heightAnchor.constraint(equalToConstant: 56.autoSized),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 32.autoSized),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            tableView.bottomAnchor.constraint(equalTo: bottomTabBar.topAnchor, constant: -10.autoSized)
        ])
    }
}

// MARK: - TableView Delegate & Data Source
extension SoundsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return soundCategories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundTableViewCell.identifier, for: indexPath) as? SoundTableViewCell else { return UITableViewCell() }
        let category = soundCategories[indexPath.section]
        cell.headingLabel.text = category.title
        cell.delegate = self
        print("Setting delegate for cell in section \(indexPath.section)")
        cell.configure(with: category.items)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let category = soundCategories[indexPath.section]
        let itemCount = category.items.count
        
        if itemCount <= 4 {
            return 180.autoSized
        } else {
            return 290.autoSized
        }
    }
}

// MARK: - For Play Screen Navigation
extension SoundsViewController: SoundTableViewCellDelegate {
    func didSelectItem(named name: String) {
        let playViewController = PlayViewController(initialSoundTitle: name)
        playViewController.modalPresentationStyle = .fullScreen
        present(playViewController, animated: true)
    }
}

extension SoundsViewController: SearchBarViewDelegate {
    func searchBar(_ searchBar: SearchBarView, didUpdateSearchText text: String) {
        // searching functionality will go here
    }
}
