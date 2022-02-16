//
//  TransactionListModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionListModuleConfigurator {

    // MARK: - Internal methods

    func configure(with wallet: Wallet) -> (TransactionListViewController, TransactionListModuleOutput) {
        let view = TransactionListViewController()
        
        let dataStoreManager = DataStoreManager()
        let presenter = TransactionListPresenter(with: wallet, dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
