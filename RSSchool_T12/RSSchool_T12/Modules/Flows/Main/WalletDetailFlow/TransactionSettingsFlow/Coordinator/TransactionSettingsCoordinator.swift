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
    
    init(router: Routable, transaction: Transaction? = nil) {
        self.router = router
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
            showCreateTransaction()
        }
    }
}

// MARK: - Private methods

private extension TransactionSettingsCoordinator {
    
    func showCreateTransaction() {
        
        let createTransactionConfigurator = CreateTransactionModuleConfigurator()
        let (view, input, output) = createTransactionConfigurator.configure()
        
        router.push(view)
    }
}
