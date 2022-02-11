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
    
}


// MARK: - Private methods
private extension MainCoordinator {
    
    func performMainFlow() {
        showWalletList()
    }
    
    func showWalletList() {
        let walletListConfigurator = WalletListModuleConfigurator()
        let (view, output) = walletListConfigurator.configure()
        
        router.setNavigationControllerRootModule(view, hideBar: true)
    }
    
    func performWalletSettingsFlow(_ wallet: Wallet? = nil) {
        let coordinator = factory.makeWalletSettingsCoordinator(router: router, wallet: wallet)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
