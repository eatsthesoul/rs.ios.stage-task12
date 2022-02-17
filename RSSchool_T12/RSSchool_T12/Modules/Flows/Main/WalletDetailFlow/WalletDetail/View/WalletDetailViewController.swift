//
//  WalletDetailViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import UIKit

final class WalletDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var addTransactionButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var transactionsViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var transactionViewToCollectionViewVerticalSpacing: NSLayoutConstraint!
    @IBOutlet weak var collectionViewToTransactionViewBottom: NSLayoutConstraint!
    
    // MARK: - Properties
    
    static let nibName = "WalletDetailViewController"
    var output: WalletDetailViewOutput?
    
    // MARK: - Private properties
    
    private let collectionViewAdapter = ListAdapter<TransactionCollectionViewCell>()

    // MARK: - Collection view properties
    
    private var numberOfItems: Int = 0
    
    private var itemWidth: CGFloat { collectionView.bounds.width }
    private var itemHeight: CGFloat { itemWidth * 0.28 }
    private let verticalSpacing: CGFloat = 20
    
    private var possibleCollectionViewHeight: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        let window = UIApplication.shared.windows.first
        let topSafeMargin = window?.safeAreaInsets.top ?? 0
        let bottomSafeMargin = window?.safeAreaInsets.bottom ?? 0
        
        let collectionViewTopMargin = topSafeMargin + transactionsViewTopConstraint.constant + transactionViewToCollectionViewVerticalSpacing.constant
        
        let collectionViewBottomMargin = collectionViewToTransactionViewBottom.constant + bottomSafeMargin
        
        let collectionViewHeight = screenHeight - collectionViewTopMargin - collectionViewBottomMargin
        return collectionViewHeight
    }
    
    private var possibleNumberOfItems: Int {
        let itemWithSpacingHeight = itemHeight + verticalSpacing
        let possibleNumberOfCells = Int((possibleCollectionViewHeight + verticalSpacing) / itemWithSpacingHeight)
        return possibleNumberOfCells
    }
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupCollectionView()
        updateCollectionViewHeight()
        addButtonTargets()
        
        output?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    // MARK: - IBActions
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        output?.showAllTransactions()
    }
    
    @IBAction func addTransactionTapped(_ sender: Any) {
        output?.addTransaction()
    }
    
}

// MARK: - WalletDetailViewInput

extension WalletDetailViewController: WalletDetailViewInput {
    
    func setupInitialState(with walletName: String) {
        navigationBar.title = walletName
    }
    
    func setup(items: [TransactionCellViewModel]) {
        
        //if there are more items than view can contain
        if items.count >= possibleNumberOfItems {
            numberOfItems = possibleNumberOfItems
            collectionViewAdapter.configure(with: Array(items[0..<possibleNumberOfItems]))
        } else {
            numberOfItems = items.count
            collectionViewAdapter.configure(with: items)
        }
        
        updateCollectionViewHeight()
    }
    
    func setup(balance: String?) {
        balanceLabel.text = balance
    }
}

// MARK: - Private methods

private extension WalletDetailViewController {
    
    func setupAppearance() {
        seeAllButton.setTitleColor(.deepSaffron, for: .highlighted)
        addTransactionButton.setTitleColor(.deepSaffron, for: .highlighted)
    }
    
    func updateCollectionViewHeight() {
        if numberOfItems == 0 {
            collectionViewHeightConstraint.constant = 0
        } else {
            let height = CGFloat(numberOfItems) * (itemHeight + verticalSpacing) - verticalSpacing
            collectionViewHeightConstraint.constant = height
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = verticalSpacing
        collectionView.collectionViewLayout = layout
        
        collectionViewAdapter.setup(collectionView: collectionView)
        collectionViewAdapter.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    func addButtonTargets() {
        navigationBar.leftButtonHandler = output?.leftNavigationBarButtonTapped
    }
}
