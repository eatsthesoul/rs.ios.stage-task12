//
//  CreateTransactionModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class CreateTransactionModuleConfigurator {

    // MARK: - Internal methods

    func configure(with wallet: Wallet) -> (TransactionSettingsViewController, CreateTransactionModuleInput,  CreateTransactionModuleOutput) {
        
        let nibName = TransactionSettingsViewController.nibName
        let view = TransactionSettingsViewController(nibName: nibName, bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let presenter = CreateTransactionPresenter(wallet: wallet, dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }

}
