//
//  CoordinatorFactoryProtocol.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable, factory: CoordinatorFactoryProtocol) -> Coordinatable & MainCoordinatorOutput
    func makeWalletSettingsCoordinator(router: Routable, wallet: Wallet?) -> Coordinatable & WalletSettingsCoordinatorOutput
    func makeWalletDetailCoordinator(router: Routable, factory: CoordinatorFactoryProtocol, wallet: Wallet) -> Coordinatable & WalletCoordinatorOutput
    func makeTransactionSettingsCoordinator(router: Routable, wallet: Wallet, transaction: Transaction?) -> Coordinatable & TransactionSettingsCoordinatorOutput
}
