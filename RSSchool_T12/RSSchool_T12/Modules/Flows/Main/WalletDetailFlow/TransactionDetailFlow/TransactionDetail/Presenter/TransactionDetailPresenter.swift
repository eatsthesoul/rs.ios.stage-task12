//
//  TransactionDetailPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionDetailPresenter: TransactionDetailViewOutput, TransactionDetailModuleInput, TransactionDetailModuleOutput {

    // MARK: - TransactionDetailModuleOutput

    // MARK: - Properties

    weak var view: TransactionDetailViewInput?
    
    let transaction: Transaction
    let wallet: Wallet
    
    // MARK: - Initialization and deinitialization
    
    init(transaction: Transaction, wallet: Wallet) {
        self.transaction = transaction
        self.wallet = wallet
    }

    // MARK: - TransactionDetailViewOutput

    func viewLoaded() {
        
    }

    // MARK: - TransactionDetailModuleInput

}
