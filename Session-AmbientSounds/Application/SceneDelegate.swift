//
//  SceneDelegate.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 16/11/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        // Check if onboarding is completed
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        
        if hasCompletedOnboarding {
            // Onboarding is completed; show HomeViewController
            let nav = UINavigationController(rootViewController: OnboardingViewController())
            window?.rootViewController = nav
            nav.setNavigationBarHidden(true, animated: false)
        } else {
            // Onboarding not completed; show OnboardingViewController
            let onboardingVC = OnboardingViewController()
            onboardingVC.onboardingCompletionHandler = {
                // Update UserDefaults to indicate onboarding completion
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                UserDefaults.standard.synchronize()
                
                // Switch to HomeViewController
                let nav = UINavigationController(rootViewController: OnboardingViewController())
                self.window?.rootViewController = nav
                nav.setNavigationBarHidden(true, animated: false)
                self.window?.makeKeyAndVisible()
            }
            window?.rootViewController = onboardingVC
        }
        
        window?.makeKeyAndVisible()
    }
}


