//
//  WalletDetailPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class WalletDetailPresenter: WalletDetailModuleInput, WalletDetailModuleOutput {

    // MARK: - WalletDetailModuleOutput
    
    var didDismiss: CompletionBlock?
    var didShowAllTransactions: Closure<Wallet>?
    var didAddTransaction: CompletionBlock?
    var didSelectTransaction: Closure<Transaction>?

    // MARK: - Properties

    weak var view: WalletDetailViewInput?
    
    // MARK: - Private properties
    
    private let dataStoreManager: DataStoreProtocol
    
    private let wallet: Wallet
    private var transactions: [Transaction] {
        didSet {
            updateTransactionsOnView()
            updateBalanceOnView()
        }
    }
    
    // MARK: - Initialization and deinitialization
    
    init(with wallet: Wallet, dataStore: DataStoreProtocol) {
        self.wallet = wallet
        self.dataStoreManager = dataStore
        self.transactions = []
    }
}


// MARK: - WalletDetailViewOutput

extension WalletDetailPresenter: WalletDetailViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState(with: wallet.title)
    }
    
    func viewWillAppear() {
        transactions = dataStoreManager.fetchTransactions(for: wallet)
    }
    
    func leftNavigationBarButtonTapped() {
        didDismiss?()
    }
    
    func showAllTransactions() {
        didShowAllTransactions?(wallet)
    }
    
    func addTransaction() {
        didAddTransaction?()
    }
    
    func didSelectCollectionViewItem(with index: Int) {
        let transaction = transactions[index]
        didSelectTransaction?(transaction)
    }
}

// MARK: - Private methods

extension WalletDetailPresenter {
    
    //this method will be called every time transactions are updated
    func updateTransactionsOnView() {

        var viewModels = [TransactionCellViewModel]()
        
        transactions.forEach { transaction in
            let viewModel = TransactionCellViewModel(with: transaction)
            viewModels.append(viewModel)
        }
        
        view?.setup(items: viewModels)
    }
    
    //this method will be called every time transactions are updated
    func updateBalanceOnView() {
        let balance = dataStoreManager.totalBalance(for: wallet)
        let balanceString = Currency.formattedString(for: balance, currencyCode: wallet.currencyCode)
        view?.setup(balance: balanceString)
    }
}
