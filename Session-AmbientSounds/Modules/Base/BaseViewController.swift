//
//  BaseViewController.swift
//  
//
//  Created by Attabiq Khan on 30/10/2024.
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
    private var viewControllersCache: [TabBarFeatures: UIViewController] = [:]
    
    init(initialTab: TabBarFeatures? = nil) {
        super.init(nibName: nil, bundle: nil)
        bottomTabBar.delegate = self
        if let tab = initialTab {
            TabBarManager.shared.currentTab = tab
        }
    }
    required init?(coder: NSCoder) {
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
        var viewController: UIViewController?
        if let cachedVC = viewControllersCache[tab] {
            viewController = cachedVC
        } else {
            switch tab {
            case .home:
                viewController = HomeViewController()
            case .sounds:
                viewController = SoundsViewController()
            case .add:
//                let addViewController = AddViewController()
//                addViewController.modalPresentationStyle = .overFullScreen
//                present(addViewController, animated: false)
//                return
                print("Add Tab Selected")
            case .explore:
                print("Explore Tab Selected")
            case .library:
                viewController = LibraryViewController()
            }
            if let vc = viewController {
                viewControllersCache[tab] = vc
            }
        }
        if let viewController = viewController {
            navigateTo(viewController: viewController)
        }
    }
    private func navigateTo(viewController: UIViewController) {
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                if navigationController.topViewController?.isKind(of: type(of: viewController)) == true {
                    return
                }
                navigationController.pushViewController(viewController, animated: false)
            } else {
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: false, completion: nil)
            }
        }
    }

}
