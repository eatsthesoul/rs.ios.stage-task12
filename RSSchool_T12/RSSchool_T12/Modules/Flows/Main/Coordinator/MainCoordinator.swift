//
//  MainCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router: Routable
    fileprivate let factory: CoordinatorFactoryProtocol
    
    init(router: Routable, factory: CoordinatorFactoryProtocol) {
        self.router  = router
        self.factory = factory
    }
}

// MARK: - Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        performMainFlow()
    }
}

// MARK: - Private methods
private extension MainCoordinator {
    
    func performMainFlow() {
        showWalletList()
    }
    
    func showWalletList() {
        let walletListConfigurator = WalletListModuleConfigurator()
        let (view, output) = walletListConfigurator.configure()
        
        output.didCreateNewWallet = showWalletSettings
        
        output.didSelectWallet = showWalletDetail(_:)
        
        router.setNavigationControllerRootModule(view, hideBar: true)
    }
    
    func showWalletSettings() {
        let coordinator = factory.makeWalletSettingsCoordinator(router: router, wallet: nil)
        addDependency(coordinator)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        
        coordinator.start()
    }
    
    func showWalletDetail(_ wallet: Wallet) {
        let coordinator = factory.makeWalletDetailCoordinator(router: router, factory: factory, wallet: wallet)
        addDependency(coordinator)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        
        coordinator.start()
    }
}
