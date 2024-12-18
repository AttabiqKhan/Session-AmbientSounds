//
//  BaseViewController.swift
//  
//
//  Created by Ali on 30/10/2024.
//

import Foundation
import UIKit

enum TabBarFeatures {
    case home
    case sounds
    case add
    case explore
    case library
}

class BaseViewController: UIViewController {
    
    let bottomTabBar = BottomTabBarView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bottomTabBar.delegate = self
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    func setupViews() {
        view.addSubview(bottomTabBar)
        
        NSLayoutConstraint.activate([
            bottomTabBar.heightAnchor.constraint(equalToConstant: 96.autoSized),
            bottomTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21.autoSized),
            bottomTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension BaseViewController: BottomTabBarDelegate {
    func didSelectTab(_ tab: TabBarFeatures) {
        switch tab {
        case .home:
            print("Home")
        case .sounds:
            print("Sounds")
        case .add:
            print("Add")
        case .explore:
            print("Explore")
        case .library:
            print("Library")
        }
    }
}
