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
        showWallet()
    }
}

// MARK: - Private methods

private extension WalletCoordinator {
    
    func showWallet() {
        
        let walletDetailConfigurator = WalletDetailModuleConfigurator()
        let (view, output) = walletDetailConfigurator.configure()
        
        router.push(view)
    }
}
