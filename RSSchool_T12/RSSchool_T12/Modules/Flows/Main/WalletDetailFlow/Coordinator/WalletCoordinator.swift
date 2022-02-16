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
    
    init(router: Routable, factory: CoordinatorFactoryProtocol, wallet: Wallet) {
        self.router = router
        self.wallet = wallet
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
        
        router.push(view)
    }
    
    func showAllTransactions(for wallet: Wallet) {
        
        let transactionListConfigurator = TransactionListModuleConfigurator()
        let (view, output) = transactionListConfigurator.configure(with: wallet)
        
        output.didDismiss = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(view)
    }
}
