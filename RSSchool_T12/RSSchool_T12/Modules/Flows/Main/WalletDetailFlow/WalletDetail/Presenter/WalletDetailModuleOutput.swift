//
//  WalletDetailModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletDetailModuleOutput: AnyObject {
    var didDismiss: CompletionBlock? { get set }
    var didShowAllTransactions: Closure<Wallet>? { get set }
    var didAddTransaction: CompletionBlock? { get set }
    var didSelectTransaction: Closure<Transaction>? { get set }
    var didShowEditWallet: Closure<Wallet>? { get set }
}
