//
//  TransactionTypeListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionTypeListViewController: UIViewController, TransactionTypeListViewInput {

    // MARK: - Properties

    var output: TransactionTypeListViewOutput?
    var collectionViewAdapter = ListAdapter<TransactionTypeCollectionViewCell>()
    
    // MARK: - Private properties
    
    var itemWidth: CGFloat { UIScreen.main.bounds.width - 40 }
    var itemHeight: CGFloat { 90 }
    var selectedItemWidth: CGFloat { itemWidth * 0.8 }
    var selectedItemHeight: CGFloat { 70 }
    
    // MARK: - Views
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftButtonImage = .back
        navigationBar.leftButton.style = .normal
        navigationBar.leftButtonHandler = output?.leftNavigationBarButtonTapped
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
        collectionViewAdapter.selectedItemSize = CGSize(width: selectedItemWidth, height: selectedItemHeight)
        collectionViewAdapter.insetForSections = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        collectionViewAdapter.onSelectItem = output?.didSelectType(with:)
        
        return view
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        setupAppearance()
        addSubviews()
        setupLayout()
    }
}
    
    

// MARK: - CurrencyListViewInput

extension TransactionTypeListViewController {
    func setupInitialState(with title: String) {
        navigationBar.title = title
    }
    
    func setup(items: [TransactionTypeCellViewModel], with selectedIndex: Int?) {
        collectionViewAdapter.configure(with: items)
        collectionViewAdapter.selectedCellIndex = selectedIndex
    }
}

// MARK: - Private methods

private extension TransactionTypeListViewController {
    
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
