//
//  TransactionDetailModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure(with transaction: Transaction, wallet: Wallet) -> (TransactionDetailViewController, TransactionDetailModuleInput, TransactionDetailModuleOutput) {
        
        let nibName = TransactionDetailViewController.nibName
        let view = TransactionDetailViewController(nibName: nibName, bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let presenter = TransactionDetailPresenter(transaction: transaction, wallet: wallet, dataStore: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }

}
