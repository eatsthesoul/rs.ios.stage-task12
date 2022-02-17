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

    func configure() -> (TransactionSettingsViewController, CreateTransactionModuleInput,  CreateTransactionModuleOutput) {
        
        let nibName = TransactionSettingsViewController.nibName
        let view = TransactionSettingsViewController(nibName: nibName, bundle: nil)
        
        let dataStoreManager = DataStoreManager()
        let presenter = CreateTransactionPresenter(dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }

}
