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
        let (view, output) = transactionDetailConfigurator.configure(with: transaction, wallet: wallet)
        
        router.push(view)
    }
}
