//
//  WalletCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import Foundation

final class WalletCoordinator: BaseCoordinator, WalletCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router: Routable
    fileprivate let wallet: Wallet
    fileprivate let factory: CoordinatorFactoryProtocol
    
    init(router: Routable, factory: CoordinatorFactoryProtocol, wallet: Wallet) {
        self.router = router
        self.wallet = wallet
        self.factory = factory
    }
}

// MARK: - Coordinatable
extension WalletCoordinator: Coordinatable {
    func start() {
        showWallet(wallet)
    }
}

// MARK: - Private methods

private extension WalletCoordinator {
    
    func showWallet(_ wallet: Wallet) {
        
        let walletDetailConfigurator = WalletDetailModuleConfigurator()
        let (view, output) = walletDetailConfigurator.configure(with: wallet)
        
        output.didDismiss = { [weak self] in
            self?.router.popModule()
            self?.finishFlow?()
        }
        
        output.didShowAllTransactions = { [weak self] wallet in
            self?.showAllTransactions(for: wallet)
        }
        
        output.didAddTransaction = { [weak self] in
            self?.showAddTransaction(with: wallet)
        }
        
        output.didSelectTransaction = { [weak self] transaction in
            self?.showTransactionDetail(for: transaction, wallet: wallet)
        }
        
        router.push(view)
    }
    
    func showAllTransactions(for wallet: Wallet) {
        
        let transactionListConfigurator = TransactionListModuleConfigurator()
        let (view, output) = transactionListConfigurator.configure(with: wallet)
        
        output.didDismiss = { [weak self] in
            self?.router.popModule()
        }
        
        output.didSelectTransaction = { [weak self] transaction in
            self?.showTransactionDetail(for: transaction, wallet: wallet)
        }
        
        router.push(view)
    }
    
    func showAddTransaction(with wallet: Wallet) {
        
        let coordinator = factory.makeTransactionSettingsCoordinator(router: router, wallet: wallet, transaction: nil)
        addDependency(coordinator)

        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }

        coordinator.start()
    }
    
    func showTransactionDetail(for transaction: Transaction, wallet: Wallet) {
        
        let transactionDetailCoordinator = factory.makeTransactionDetailCoordinator(router: router, transaction: transaction, wallet: wallet)
        
        addDependency(transactionDetailCoordinator)

        transactionDetailCoordinator.finishFlow = { [weak self] in
            self?.removeDependency(transactionDetailCoordinator)
        }

        transactionDetailCoordinator.start()
    }
}
