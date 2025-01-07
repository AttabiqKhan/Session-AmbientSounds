//
//  PresentationHelper.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 06/01/2025.
//

import Foundation
import UIKit

class PresentationHelper: NSObject {
    
    // MARK: - Properties
    private var containerView: UIView
    private var viewController: UIViewController
    
    // MARK: - Initializer
    init(containerView: UIView, viewController: UIViewController) {
        self.containerView = containerView
        self.viewController = viewController
        super.init()
    }
    
    // MARK: - Public Methods
    func dismissSelf() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.viewController.view.bounds.height)
            self.viewController.view.backgroundColor = .clear
        }, completion: { _ in
            self.viewController.dismiss(animated: false, completion: nil)
        })
    }
    
    func presentSelf() {
        containerView.transform = CGAffineTransform(translationX: 0, y: viewController.view.bounds.height)
        UIView.animate(withDuration: 0.3) {
            self.viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.containerView.transform = .identity
        }
    }
    
    // MARK: - Gesture Handling
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: containerView)
        let progress = translation.y / containerView.bounds.height
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                containerView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: containerView).y
            let shouldDismiss = progress > 0.3 || velocity > 1000
            if shouldDismiss {
                dismissSelf()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.containerView.transform = .identity
                }
            }
        default:
            break
        }
    }
}
