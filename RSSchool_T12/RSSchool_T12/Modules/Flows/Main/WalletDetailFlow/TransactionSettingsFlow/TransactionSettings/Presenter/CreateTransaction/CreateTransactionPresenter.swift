//
//  CreateTransactionPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import Foundation

final class CreateTransactionPresenter: CreateTransactionModuleOutput {

    // MARK: - TransactionSettingsModuleOutput
    
    var showTransactionTypeList: Closure<TransactionType>?
    var didGetTitleWarning: CompletionBlock?
    var didGetSumWarning: CompletionBlock?
    var didGetNoteWarning: CompletionBlock?
    var didCreateTransactionMessage: CompletionBlock?
    
    // MARK: - Properties

    weak var view: TransactionSettingsViewInput?
    
    let dataStoreManager: DataStoreProtocol
    
    // MARK: - Private properties
    
    private let navigationBarTitle = "Add transaction"
    
    private var wallet: Wallet
    private var transaction: TransactionSettingsViewModel
    
    // MARK: - Initialization and deinitialization
    
    init(wallet: Wallet, dataStoreManager: DataStoreProtocol) {
        self.wallet = wallet
        self.dataStoreManager = dataStoreManager
        transaction = TransactionSettingsViewModel(title: "", change: "", isOutcome: true, note: nil, type: .other)
    }
}

// MARK: - TransactionSettingsViewOutput

extension CreateTransactionPresenter: TransactionSettingsViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState(with: navigationBarTitle)
    }
    
    func viewWillAppear() {
        view?.setupView(with: transaction)
        
    }
    
    // here we check transaction for errors. If there is, we will show alert with error. If there are none, show alert offering to create new transaction
    func leftNavigationBarButtonTapped() {
        
        if transaction.title.count == 0 || transaction.title.count > 20 {
            didGetTitleWarning?()
            return
        }
        
        if transaction.change.count == 0 || transaction.change == "0" {
            didGetSumWarning?()
            return
        }
        
        if let note = transaction.note, note.count > 250 {
            didGetNoteWarning?()
            return
        }
        
        //if we don't get any warning we get suggestion to create new wallet
        didCreateTransactionMessage?()
    }
    
    func didTapOnTypePanel() {
        showTransactionTypeList?(transaction.type)
    }
    
    func transactionTitleDidUpdate(_ string: String) {
        transaction.title = string
    }
    
    func transactionSumDidUpdate(_ sum: String) {
        transaction.change = sum
    }
    
    func isOutcomeDidUpdate(_ bool: Bool) {
        transaction.isOutcome = bool
    }
    
    func transactionNoteDidUpdate(_ string: String) {
        transaction.note = string
    }
}

// MARK: - CreateTransactionModuleInput

extension CreateTransactionPresenter: CreateTransactionModuleInput {
    
    func saveTransaction() {
        dataStoreManager.createNewTransaction(transaction, for: wallet)
    }
    
    func set(transactionType: TransactionType) {
        transaction.type = transactionType
    }
}
