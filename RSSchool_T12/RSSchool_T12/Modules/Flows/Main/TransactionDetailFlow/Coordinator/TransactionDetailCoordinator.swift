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
    fileprivate let transaction: Transaction
    fileprivate let wallet: Wallet
    
    init(router: Routable, transaction: Transaction, wallet: Wallet) {
        self.router = router
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
        }
        
        output.didShowDeleteTransactionMessage = { [weak self] in
            self?.showDeleteTransactionMessage(completion: { [weak input] answer in
                if answer { input?.deleteCurrentTransaction() }
            })
        }
        
        router.push(view)
    }
    
    //completion return bool answer to delete transaction or not
    func showDeleteTransactionMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.deleteTransactionAlert { [weak self] in
            completion(false)
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            completion(true)
            self?.router.dismissModule()
        }
        
        router.present(alert)
    }
}
