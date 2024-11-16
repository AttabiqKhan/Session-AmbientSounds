//
//  BaseViewController.swift
//  AmbientSoundApp
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
    
//    private let headingLabel = Label(texttitle: "Based on\nyour mood", textcolor: .black, font: .bold(ofSize: 28), numOflines: 0, textalignment: .left)
    private let headingLabel: Label = {
        let label = Label(text: "Based on\nyour mood", textAlignment: .left, numberOfLines: 0, textColor: .black)
        label.font = .bold(ofSize: 28.autoSized)
        return label
    }()
    private let bottomTabBar = BottomTabBarView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    open func setupViews() {
        view.addSubview(headingLabel)
        view.addSubview(bottomTabBar)
        
        NSLayoutConstraint.activate([
            
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 83.autoSized),
            
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
            print("")
        case .sounds:
            print("")
        case .add:
            print("")
        case .explore:
            print("")
        case .library:
            print("")
        }
    }
    
}
