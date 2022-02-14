//
//  CoordinatorFactory.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import UIKit

final class CoordinatorFactory {
    
}

// MARK: - CoordinatorFactoryProtocol
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeMainCoordinator(router: Routable, factory: CoordinatorFactoryProtocol) -> Coordinatable & MainCoordinatorOutput {
        MainCoordinator(router: router, factory: factory)
    }
    
    func makeWalletSettingsCoordinator(router: Routable, wallet: Wallet? = nil) -> Coordinatable & WalletSettingsCoordinatorOutput {
        WalletSettingsCoordinator(router: router, wallet: wallet)
    }
    
    func makeWalletDetailCoordinator(router: Routable, factory: CoordinatorFactoryProtocol, wallet: Wallet) -> Coordinatable & WalletCoordinatorOutput {
        WalletCoordinator(router: router, factory: factory, wallet: wallet)
    }
}
