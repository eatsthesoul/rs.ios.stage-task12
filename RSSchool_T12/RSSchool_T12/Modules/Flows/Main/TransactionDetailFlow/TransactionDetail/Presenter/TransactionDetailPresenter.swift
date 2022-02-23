//
//  TransactionDetailPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionDetailPresenter: TransactionDetailModuleOutput {

    // MARK: - TransactionDetailModuleOutput
    
    var didDismiss: CompletionBlock?
    var didShowEditTransaction: Closure<Transaction>?
    var didShowDeleteTransactionMessage: CompletionBlock?

    // MARK: - Properties

    weak var view: TransactionDetailViewInput?
    
    let dataStoreManager: DataStoreProtocol
    
    private var transaction: Transaction {
        didSet {
            updateView()
        }
    }
    private let wallet: Wallet
    
    
    
    // MARK: - Initialization and deinitialization
    
    init(transaction: Transaction, wallet: Wallet, dataStore: DataStoreProtocol) {
        self.transaction = transaction
        self.wallet = wallet
        self.dataStoreManager = dataStore
    }
}

// MARK: - Private methods

private extension TransactionDetailPresenter {
    
    func updateTransaction() {
        guard let transaction = dataStoreManager.fetchTransaction(with: transaction.objectID)
        else { return }
        self.transaction = transaction
    }

    func updateView() {
        let transactionViewModel = TransactionDetailViewModel(with: transaction)
        view?.setup(transaction: transactionViewModel)
    }
}

// MARK: - TransactionDetailViewOutput

extension TransactionDetailPresenter: TransactionDetailViewOutput {
    
    func viewLoaded() {
        updateView()
    }
    
    func viewWillAppear() {
        //we need to update here because of want to get an updated transaction if it will be changed
        updateTransaction()
    }
    
    func leftNavigationBarButtonTapped() {
        didDismiss?()
    }
    
    func editTransaction() {
        didShowEditTransaction?(transaction)
    }
    
    func deleteTransaction() {
        didShowDeleteTransactionMessage?()
    }
}

// MARK: - TransactionDetailModuleInput

extension TransactionDetailPresenter: TransactionDetailModuleInput {
    
    func deleteCurrentTransaction() {
        dataStoreManager.deleteTransaction(transaction, from: wallet)
        didDismiss?()
    }
}
