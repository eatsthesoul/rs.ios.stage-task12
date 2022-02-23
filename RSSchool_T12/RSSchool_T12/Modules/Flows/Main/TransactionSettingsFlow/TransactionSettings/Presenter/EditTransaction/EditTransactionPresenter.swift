//
//  EditTransactionPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 23.02.22.
//

import Foundation

final class EditTransactionPresenter: EditTransactionModuleOutput {

    // MARK: - EditTransactionModuleOutput
    
    var showTransactionTypeList: Closure<TransactionType>?
    var didShowEditTransactionMessage: CompletionBlock?
    var didDismiss: CompletionBlock?
    var didGetTitleWarning: CompletionBlock?
    var didGetSumWarning: CompletionBlock?
    var didGetNoteWarning: CompletionBlock?
    
    // MARK: - Properties

    weak var view: TransactionSettingsViewInput?
    
    // MARK: - Private properties
    
    private let navigationBarTitle = "Edit transaction"
    private let dataStoreManager: DataStoreProtocol
    private var transaction: Transaction
    
    //it is a view model we are working with. It take all changes from view
    private var transactionViewModel: TransactionSettingsViewModel
    
    // MARK: - Initialization and deinitialization
    
    init(transaction: Transaction, dataStoreManager: DataStoreProtocol) {
        self.transaction = transaction
        self.dataStoreManager = dataStoreManager
        transactionViewModel = TransactionSettingsViewModel(transaction)
    }
}

// MARK: - TransactionSettingsViewOutput

extension EditTransactionPresenter: TransactionSettingsViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState(with: navigationBarTitle)
    }
    
    func viewWillAppear() {
        view?.setupView(with: transactionViewModel)
    }
    
    func leftNavigationBarButtonTapped() {
        
        // If there are changes in transactionViewModel, we show alert offering to edit transaction
        let notChangedTransactionViewModel = TransactionSettingsViewModel(transaction)
        
        if notChangedTransactionViewModel != transactionViewModel {
            didShowEditTransactionMessage?()
        }
        else { //if no, just close module
            didDismiss?()
        }
    }
    
    func didTapOnTypePanel() {
        showTransactionTypeList?(transactionViewModel.type)
    }
    
    func transactionTitleDidUpdate(_ string: String) {
        transactionViewModel.title = string
    }
    
    func transactionSumDidUpdate(_ sum: String) {
        transactionViewModel.change = sum
    }
    
    func isOutcomeDidUpdate(_ bool: Bool) {
        transactionViewModel.isOutcome = bool
    }
    
    func transactionNoteDidUpdate(_ string: String) {
        transactionViewModel.note = string
    }
}

// MARK: - ModuleInput

extension EditTransactionPresenter: EditTransactionModuleInput, SettingsTransactionModuleInput {
    
    func set(transactionType: TransactionType) {
        transactionViewModel.type = transactionType
    }
    
    func editTransaction() {
        
        //entered transaction data validation
        
        if transactionViewModel.title.count == 0 || transaction.title.count > 20 {
            didGetTitleWarning?()
            return
        }
        
        if transactionViewModel.change.count == 0 || transactionViewModel.change == "0" {
            didGetSumWarning?()
            return
        }
        
        if let note = transactionViewModel.note, note.count > 250 {
            didGetNoteWarning?()
            return
        }
        
        //if there is no error, update transaction
        dataStoreManager.updateTransaction(transaction, with: transactionViewModel)
        //and close module
        didDismiss?()
    }
}
