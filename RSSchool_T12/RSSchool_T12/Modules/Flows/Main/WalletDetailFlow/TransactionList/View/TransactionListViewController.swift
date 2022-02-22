//
//  TransactionListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionListViewController: UIViewController {
    
    // MARK: - Properties

    var output: TransactionListViewOutput?
    var collectionViewAdapter = ListAdapter<TransactionCollectionViewCell>()
    
    
    // MARK: - Private properties
    
    private var itemWidth: CGFloat { UIScreen.main.bounds.width - 40 }
    private let itemHeight: CGFloat = 90
    
    // MARK: - Views
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.title = "Transactions"
        navigationBar.leftButtonImage = .back
        navigationBar.rightButton.style = .normal
        navigationBar.leftButtonHandler = output?.leftNavigationBarTapped
        return navigationBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewAdapter.setup(collectionView: view)
        collectionViewAdapter.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewAdapter.insetForSections = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        collectionViewAdapter.onSelectItem = output?.didSelectCollectionViewItem(with:)
        
        return view
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        addSubviews()
        setupLayout()
        
        output?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
}

// MARK: - TransactionListViewInput

extension TransactionListViewController: TransactionListViewInput {
    
    func setup(items: [TransactionCellViewModel]) {
        collectionViewAdapter.configure(with: items)
    }
}


private extension TransactionListViewController {
    
    func setupAppearance() {
        view.makeThemeBackground()
    }
    
    func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
