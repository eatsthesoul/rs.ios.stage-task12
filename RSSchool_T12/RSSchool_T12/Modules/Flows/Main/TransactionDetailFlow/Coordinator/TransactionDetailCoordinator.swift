//
//  TransactionDetailCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22.02.22.
//

import UIKit

final class TransactionDetailCoordinator: BaseCoordinator, TransactionDetailCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router: Routable
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let transaction: Transaction
    fileprivate let wallet: Wallet
    
    init(router: Routable, factory: CoordinatorFactoryProtocol, transaction: Transaction, wallet: Wallet) {
        self.router = router
        self.factory = factory
        self.transaction = transaction
        self.wallet = wallet
    }
}

// MARK: - Coordinatable
extension TransactionDetailCoordinator: Coordinatable {
    func start() {
       showTransactionDetail(for: transaction, wallet: wallet)
    }
}

// MARK: - Private methods

private extension TransactionDetailCoordinator {
    
    func showTransactionDetail(for transaction: Transaction, wallet: Wallet) {
        
        let transactionDetailConfigurator = TransactionDetailModuleConfigurator()
        let (view, input, output) = transactionDetailConfigurator.configure(with: transaction, wallet: wallet)
        
        output.didDismiss = { [weak self] in
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        output.didShowDeleteTransactionMessage = { [weak self, weak input] in
            self?.showDeleteTransactionMessage(completion: { answer in
                if answer {
                    input?.deleteCurrentTransaction()
                    self?.router.popModule()
                    self?.finishFlow?()
                }
            })
        }
        
        output.didShowEditTransaction = { [weak self] transaction in
            self?.showEditTransaction(transaction, wallet: wallet)
        }
        
        router.push(view)
    }
    
    func showEditTransaction(_ transaction: Transaction, wallet: Wallet) {
        
        let editTransactionCoordinator = factory.makeTransactionSettingsCoordinator(router: router,
                                                                                    wallet: wallet,
                                                                                    transaction: transaction)
        addDependency(editTransactionCoordinator)
        
        editTransactionCoordinator.finishFlow = { [weak self, weak editTransactionCoordinator] in
            self?.removeDependency(editTransactionCoordinator)
        }
        
        editTransactionCoordinator.start()
    }
    
    //completion return bool answer to delete transaction or not
    func showDeleteTransactionMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.deleteTransactionAlert { [weak self] in
            completion(false)
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            completion(true)
        }
        
        router.present(alert)
    }
}
