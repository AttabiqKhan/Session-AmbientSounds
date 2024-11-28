//
//  CustomPageControl.swift
//  DummyOnboarding
//
//  Created by Attabiq Khan on 06/11/2024.
//

import UIKit

class CustomPageControl: UIView {
    
    // MARK: - UI Elements
    private var indicatorViews: [UIView] = []
    
    // MARK: - Properties
    private var numberOfPages: Int = 0
    var currentPage: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    private let activeIndicatorWidth: CGFloat = 24.autoSized
    private let inactiveIndicatorWidth: CGFloat = 24.autoSized
    private let indicatorHeight: CGFloat = 4.autoSized
    private let spacing: CGFloat = 8.autoSized
    override var intrinsicContentSize: CGSize {
        let totalWidth = activeIndicatorWidth +
        CGFloat(numberOfPages - 1) * (inactiveIndicatorWidth + spacing)
        return CGSize(width: totalWidth, height: indicatorHeight)
    }
   
    // MARK: - Initializers
    init(numberOfPages: Int) {
        super.init(frame: .zero)
        self.numberOfPages = numberOfPages
        setupIndicators()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicators()
    }
    
    // MARK: - Functions
    private func setupIndicators() {
        // Remove existing indicators
        indicatorViews.forEach { $0.removeFromSuperview() }
        indicatorViews.removeAll()
        
        // Create new indicators
        for _ in 0..<numberOfPages {
            let indicator = UIView()
            indicator.backgroundColor = .lightGray
            indicator.layer.cornerRadius = indicatorHeight / 2
            addSubview(indicator)
            indicatorViews.append(indicator)
        }
        updateIndicators()
    }
    private func updateIndicators() {
        for (index, indicator) in indicatorViews.enumerated() {
            // Update appearance
            indicator.backgroundColor = index == currentPage ? .midnightPurple : .softPurple
            // Update size
            let width = index == currentPage ? activeIndicatorWidth : inactiveIndicatorWidth
            indicator.frame.size = CGSize(width: width, height: indicatorHeight)
            
            // Calculate x position
            var x: CGFloat = 0
            for i in 0..<index {
                x += (i == currentPage ? activeIndicatorWidth : inactiveIndicatorWidth) + spacing
            }
            // Update position
            indicator.frame.origin.x = x
            indicator.frame.origin.y = 0
        }
    }
    // Public interface
    func setCurrentPage(_ page: Int) {
        guard page >= 0 && page < numberOfPages else { return }
        currentPage = page
        updateIndicators()
    }
    
  
}
