//
//  TransactionListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionListPresenter: TransactionListModuleInput, TransactionListModuleOutput {

    // MARK: - TransactionListModuleOutput
    
    var didDismiss: CompletionBlock?

    // MARK: - Properties

    weak var view: TransactionListViewInput?
    
    // MARK: - Private properties
    
    private let wallet: Wallet
    private var transactions: [Transaction] {
        didSet {
            updateTransactionsOnView()
        }
    }
    
    private let dataStoreMagager: DataStoreProtocol
    
    // MARK: - Initialization and deinitialization
    
    init(with wallet: Wallet, dataStoreManager: DataStoreProtocol) {
        transactions = []
        self.wallet = wallet
        self.dataStoreMagager = dataStoreManager
    }
}

// MARK: - TransactionListViewOutput

extension TransactionListPresenter: TransactionListViewOutput {
    
    func viewLoaded() {
        
    }
    
    func viewWillAppear() {
        updateTransactions()
    }
    
    func leftNavigationBarTapped() {
        didDismiss?()
    }
}

extension TransactionListPresenter {
    
    func updateTransactions() {
        transactions = dataStoreMagager.fetchTransactions(for: wallet)
    }
    
    //this method will be called every time transactions are updated
    func updateTransactionsOnView() {

        var viewModels = [TransactionCellViewModel]()
        
        transactions.forEach { transaction in
            let viewModel = TransactionCellViewModel(with: transaction)
            viewModels.append(viewModel)
        }
        
        view?.setup(items: viewModels)
    }
}
