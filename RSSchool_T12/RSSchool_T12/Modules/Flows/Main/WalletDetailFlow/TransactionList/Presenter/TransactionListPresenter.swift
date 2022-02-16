//
//  TransactionListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionListPresenter: TransactionListViewOutput, TransactionListModuleInput, TransactionListModuleOutput {

    // MARK: - TransactionListModuleOutput

    // MARK: - Properties

    weak var view: TransactionListViewInput?
    
    // MARK: Private properties
    
    let wallet: Wallet
    
    // MARK: - Initialization and deinitialization
    
    init(with wallet: Wallet) {
        self.wallet = wallet
    }

    // MARK: - TransactionListViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - TransactionListModuleInput

}
