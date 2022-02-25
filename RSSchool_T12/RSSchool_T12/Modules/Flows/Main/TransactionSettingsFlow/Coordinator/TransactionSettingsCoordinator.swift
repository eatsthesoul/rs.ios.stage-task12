//
//  TransactionSettingsCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import Foundation

import UIKit

final class TransactionSettingsCoordinator: BaseCoordinator, TransactionSettingsCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router: Routable
    fileprivate let transaction: Transaction?
    fileprivate let wallet: Wallet
    
    init(router: Routable, wallet: Wallet, transaction: Transaction? = nil) {
        self.router = router
        self.wallet = wallet
        self.transaction = transaction
    }
}

// MARK: - Coordinatable
extension TransactionSettingsCoordinator: Coordinatable {
    func start() {
        if transaction != nil {
            showEditTransaction(with: transaction!)
        }
        else {
            showCreateTransaction(with: wallet)
        }
    }
}

// MARK: - Private methods

private extension TransactionSettingsCoordinator {
    
    func showEditTransaction(with transaction: Transaction) {
        
        let editTransactionConfigurator = EditTransactionModuleConfigurator()
        let (view, settingsInput, input, output) = editTransactionConfigurator.configure(with: transaction)
        
        output.showTransactionTypeList = { [weak self, weak settingsInput] transactionType in
            self?.showTransactionTypeList(with: transactionType, input: settingsInput)
        }
        
        output.didShowEditTransactionMessage = { [weak self] in
            self?.showEditTransactionMessage(completion: { [weak input] answer in
                if answer { input?.editTransaction() }
            })
        }
        
        output.didGetTitleWarning = { [weak self] in
            self?.showTitleWarning()
        }
        
        output.didGetSumWarning = { [weak self] in
            self?.showSumWarning()
        }
        
        output.didGetNoteWarning = { [weak self] in
            self?.showNoteWarning()
        }
        
        output.didDismiss = { [weak self] in
            self?.dismissModule()
        }
        
        router.push(view)
    }
    
    func showCreateTransaction(with wallet: Wallet) {
        
        let createTransactionConfigurator = CreateTransactionModuleConfigurator()
        let (view, settingsInput, input, output) = createTransactionConfigurator.configure(with: wallet)
        
        output.showTransactionTypeList = { [weak self, weak settingsInput] transactionType in
            self?.showTransactionTypeList(with: transactionType, input: settingsInput)
        }
        
        output.didGetTitleWarning = { [weak self] in
            self?.showTitleWarning()
        }
        
        output.didGetSumWarning = { [weak self] in
            self?.showSumWarning()
        }
        
        output.didGetNoteWarning = { [weak self] in
            self?.showNoteWarning()
        }
        
        output.didCreateTransactionMessage = { [weak self] in
            self?.showCreateTransactionMessage(completion: { [weak input] answer in
                if answer {    //save transition if we get positive response from message
                    input?.saveTransaction()
                }
            })
        }
        
        router.push(view)
    }
    
    func showTransactionTypeList(with selectedType: TransactionType, input: SettingsTransactionModuleInput?) {
        
        let transactionTypeListConfigurator = TransactionTypeListModuleConfigurator()
        let (view, output) = transactionTypeListConfigurator.configure(with: selectedType)
        
        output.didDismissWithType = { [weak self, weak input] type in
            self?.router.popModule(animated: true)
            input?.set(transactionType: type)
        }
        
        router.push(view)
    }
    
    func dismissModule() {
        router.popModule()
        finishFlow?()
    }
    
    // MARK: - Alerts
    
    //completion here to say what answer we get from this message
    func showCreateTransactionMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.createNewTransactionAlert { [weak self] in
            //completion here for creating a transaction
            completion(true)
            self?.router.dismissModule()
            self?.router.popModule()
            self?.finishFlow?()
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    //completion here to say what answer we get from this message
    func showEditTransactionMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.editTransactionAlert { [weak self] in
            
            self?.router.dismissModule(animated: true, completion: {
                //if true, we need to edit transaction
                completion(true)
            })
            
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert)
    }
    
    func showTitleWarning() {
        
        let alertService = AlertService()
        let alert = alertService.transactionTitleAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert)
    }
    
    func showSumWarning() {
        
        let alertService = AlertService()
        let alert = alertService.transactionSumAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert)
    }
    
    func showNoteWarning() {
        let alertService = AlertService()
        let alert = alertService.transactionSumAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert)
    }
}
