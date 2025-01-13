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

//class BaseViewController: UIViewController {
//    
//    let bottomTabBar = BottomTabBarView()
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        bottomTabBar.delegate = self
//    }
//    required public init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupViews()
//    }
//    func setupViews() {
//        view.addSubview(bottomTabBar)
//        
//        NSLayoutConstraint.activate([
//            bottomTabBar.heightAnchor.constraint(equalToConstant: 96.autoSized),
//            bottomTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21.autoSized),
//            bottomTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            bottomTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        ])
//    }
//}
//
//extension BaseViewController: BottomTabBarDelegate {
//    func didSelectTab(_ tab: TabBarFeatures) {
//        var viewController: UIViewController?
//        switch tab {
//        case .home:
//            viewController = HomeViewController()
//            print("Home")
//        case .sounds:
//            print("Sounds")
//        case .add:
//            print("Add")
//        case .explore:
//            print("Explore")
//        case .library:
//            viewController = LibraryViewController()
//            print("Library")
//        }
//        if let viewController = viewController {
//            navigateTo(viewController: viewController)
//        }
//    }
//    private func navigateTo(viewController: UIViewController) {
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(viewController, animated: false)
//        } else {
//            viewController.modalPresentationStyle = .fullScreen
//            present(viewController, animated: false, completion: nil)
//        }
//    }
//}
class BaseViewController: UIViewController {
    
    let bottomTabBar = BottomTabBarView()
    private var viewControllersCache: [TabBarFeatures: UIViewController] = [:]
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
        print("didSelectTab called for tab: \(tab)")
        var viewController: UIViewController?
        if let cachedVC = viewControllersCache[tab] {
            viewController = cachedVC
        } else {
            switch tab {
            case .home:
                viewController = HomeViewController()
                print("Home Tab Selected")
            case .sounds:
                print("Sounds Tab Selected")
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
                print("Library Tab Selected")
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
