//
//  WalletListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import UIKit

final class WalletListViewController: UIViewController {
    
    // MARK: - Nested types
    
    enum Constants {
        static let nibName = "WalletListViewController"
    }

    // MARK: - Properties

    var output: WalletListViewOutput?
    var collectionViewAdapter = ListAdapter<WalletListCollectionViewCell>()
    
    // MARK: - Private properties
    
    var itemWidth: CGFloat { UIScreen.main.bounds.width - 40 }
    var itemHeight: CGFloat { itemWidth * 0.55 }
    
    // MARK: - Views
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.title = "Wallets"
        navigationBar.rightButtonImage = .add
        navigationBar.rightButton.style = .normal
        navigationBar.rightButtonHandler = output?.rightNavigationBarTapped
        return navigationBar
    }()
    
    lazy var noWalletsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .rickBlack
        label.text = "No wallets created 😥"
        label.font = .montserrat(24, .semibold)
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewAdapter.setup(collectionView: view)
        collectionViewAdapter.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewAdapter.insetForSections = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        collectionViewAdapter.onSelectItem = output?.
        
        return view
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        
        output?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output?.viewWillAppear()
    }
}

// MARK: - WalletListViewInput

extension WalletListViewController: WalletListViewInput {
    
    func setup(items: [WalletCellViewModel]) {
        collectionViewAdapter.configure(with: items)
        noWalletsLabel.isHidden = items.count != 0
    }
}

// MARK: - Private methods

private extension WalletListViewController {
    
    func setupAppearance() {
        view.makeThemeBackground()
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
        view.addSubview(noWalletsLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            navigationBar.heightAnchor.constraint(equalToConstant: 75),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            noWalletsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noWalletsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noWalletsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            noWalletsLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
}
