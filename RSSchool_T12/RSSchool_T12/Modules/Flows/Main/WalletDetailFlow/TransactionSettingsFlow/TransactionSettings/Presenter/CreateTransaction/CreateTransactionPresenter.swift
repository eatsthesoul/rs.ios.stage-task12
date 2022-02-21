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

    // MARK: - Properties

    weak var view: TransactionSettingsViewInput?
    
    let dataStoreManager: DataStoreProtocol
    
    // MARK: - Private properties
    
    private let navigationBarTitle = "Add transaction"
    
    private var transaction: TransactionSettingsViewModel
    
    // MARK: - Initialization and deinitialization
    
    init(dataStoreManager: DataStoreProtocol) {
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
    
    func leftNavigationBarButtonTapped() {
        
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
    
    func set(transactionType: TransactionType) {
        transaction.type = transactionType
    }
}
