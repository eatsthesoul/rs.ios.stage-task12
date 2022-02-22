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
            //TODO: - add method for transaction editing
        }
        else {
            showCreateTransaction(with: wallet)
        }
    }
}

// MARK: - Private methods

private extension TransactionSettingsCoordinator {
    
    func showCreateTransaction(with wallet: Wallet) {
        
        let createTransactionConfigurator = CreateTransactionModuleConfigurator()
        let (view, input, output) = createTransactionConfigurator.configure(with: wallet)
        
        output.showTransactionTypeList = { [weak self, weak input] transactionType in
            self?.showTransactionTypeList(with: transactionType, input: input)
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
    
    func showTransactionTypeList(with selectedType: TransactionType, input: CreateTransactionModuleInput?) {
        
        let transactionTypeListConfigurator = TransactionTypeListModuleConfigurator()
        let (view, output) = transactionTypeListConfigurator.configure(with: selectedType)
        
        output.didDismissWithType = { [weak self, weak input] type in
            self?.router.popModule(animated: true)
            input?.set(transactionType: type)
        }
        
        router.push(view)
    }
    
    func showTitleWarning() {
        
        let alertService = AlertService()
        let alert = alertService.transactionTitleAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        router.present(alert)
    }
    
    func showSumWarning() {
        
        let alertService = AlertService()
        let alert = alertService.transactionSumAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        router.present(alert)
    }
    
    func showNoteWarning() {
        let alertService = AlertService()
        let alert = alertService.transactionSumAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        router.present(alert)
    }
    
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
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
}
