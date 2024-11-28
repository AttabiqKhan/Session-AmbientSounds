//
//  OnboardingViewController.swift
//  DummyOnboarding
//
//  Created by Attabiq Khan on 04/11/2024.
//


import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.bounces = false
        return collectionView
    }()
    private lazy var pageControl: CustomPageControl = {
        let pageControl = CustomPageControl(numberOfPages: onboardingItems.count)
        return pageControl
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .midnightPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32.autoSized
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "Figtree-SemiBold", size: 16.autoSized)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let onboardingItems: [OnboardingItem] = [
        OnboardingItem(
            image: "headphones1",
            title: "Soundtracks for\nevery moment",
            subtitle: "Let us suggest the perfect sound mix based on your mood and activity.",
            isLastItem: false
        ),
        OnboardingItem(
            image: "custom_sound1",
            title: "Upload Custom\nSound Elements",
            subtitle: "Upload your favorite sounds and personalize your soundscapes.",
            isLastItem: false
        ),
        OnboardingItem(
            image: "mix_sound1",
            title: "Mix Calming\nSoundscapes",
            subtitle: "Mix ambient sounds to craft the perfect vibe for any moment.",
            isLastItem: true
        )
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = .clear
        view.addGradient(colors: [.pastelPurple, .white])
        
        [collectionView, pageControl, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -32.autoSized),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -53.autoSized),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            actionButton.heightAnchor.constraint(equalToConstant: 64.autoSized)
        ])
    }
    func updateActionButtonTitle(for item: OnboardingItem) {
        if item.isLastItem {
            actionButton.setTitle("Done", for: .normal)
        } else {
            actionButton.setTitle("Next", for: .normal)
        }
    }
    
    // MARK: - Selectors
    // Note: actionButtonTapped function may seem difficult to understand hence the comments are written
    @objc private func actionButtonTapped() {
        let currentIndex = pageControl.currentPage
        print("Current Index: \(currentIndex)")
        
        if currentIndex == onboardingItems.count - 1 {
            // Navigate to the next view controller after the last page
            let vc = HomeViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // Calculate the next index's offset
            let nextIndex = currentIndex + 1
            let contentOffset = CGPoint(x: CGFloat(nextIndex) * collectionView.frame.width, y: 0)
            
            // Scroll to the next page using contentOffset
            collectionView.setContentOffset(contentOffset, animated: false)
            
            // Update the page control after the scroll starts
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.pageControl.currentPage = nextIndex
            }
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let item = onboardingItems[indexPath.item]
        cell.configure(with: item)
        updateActionButtonTitle(for: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        guard width > 0 else { return }
        
        let currentPage = Int((scrollView.contentOffset.x + (width / 2)) / width)
        pageControl.setCurrentPage(max(0, min(currentPage, onboardingItems.count - 1)))
    }
}
