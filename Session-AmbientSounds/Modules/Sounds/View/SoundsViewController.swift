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
    private let visibleLabel: Label = {
        let label = Label(
            text: "Your library is empty! Start exploring to add your favourite sounds.",
            textAlignment: .center,
            numberOfLines: 0,
            textColor: .primaryDarkGray
        )
        label.font = .medium(ofSize: 19.autoSized)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Properties
    private var soundCategories: [SoundCategory] = SoundDataProvider.getSoundCategories()
    private var filteredSoundCategories: [SoundCategory] = []
    
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
        setupTapGesture()
        searchBar.delegate = self
        filteredSoundCategories = soundCategories
    }
    
    // MARK: - Functions
    override func setupViews() {
        super.setupViews()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(visibleLabel)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.autoSized),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            searchBar.heightAnchor.constraint(equalToConstant: 56.autoSized),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 32.autoSized),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            tableView.bottomAnchor.constraint(equalTo: bottomTabBar.topAnchor, constant: -10.autoSized),
            
            visibleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            visibleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            visibleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    private func filterSoundItems(with searchText: String) {
        guard !searchText.isEmpty else {
            filteredSoundCategories = soundCategories
            tableView.reloadData()
            return
        }
        filteredSoundCategories = soundCategories.compactMap{ category in
            let filteredItems = category.items.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            return filteredItems.isEmpty ? nil : SoundCategory(title: category.title, items: filteredItems)
        }
        updateVisibleLabel()
        tableView.reloadData()
    }
    private func updateVisibleLabel() {
        if filteredSoundCategories.isEmpty {
            visibleLabel.isHidden = false
            visibleLabel.text = "No results. Explore other keywords."
        } else {
            visibleLabel.isHidden = true
        }
    }
    // MARK: - Selectors
    @objc private func didTapOutside() {
        view.endEditing(true)
    }
}

// MARK: - TableView Delegate & Data Source
extension SoundsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSoundCategories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundTableViewCell.identifier, for: indexPath) as? SoundTableViewCell else { return UITableViewCell() }
        let category = filteredSoundCategories[indexPath.section]
        cell.headingLabel.text = category.title
        cell.delegate = self
        cell.configure(with: category.items)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let itemCount = filteredSoundCategories[indexPath.section].items.count
        return itemCount <= 4 ? 180.autoSized : 290.autoSized // need to check why zeplin's constraints are not working
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

// MARK: - For Searching
extension SoundsViewController: SearchBarViewDelegate {
    func searchBar(_ searchBar: SearchBarView, didUpdateSearchText text: String) {
        filterSoundItems(with: text)
    }
}
