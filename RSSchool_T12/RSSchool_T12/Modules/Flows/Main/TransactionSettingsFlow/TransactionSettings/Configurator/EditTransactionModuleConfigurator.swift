//
//  EditTransactionModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 23.02.22.
//

import UIKit

final class EditTransactionModuleConfigurator {

    // MARK: - Internal methods

    func configure(with transaction: Transaction) -> (TransactionSettingsViewController, SettingsTransactionModuleInput, EditTransactionModuleInput,  EditTransactionModuleOutput) {
        
        let nibName = TransactionSettingsViewController.nibName
        let view = TransactionSettingsViewController(nibName: nibName, bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let presenter = EditTransactionPresenter(transaction: transaction, dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter, presenter)
    }

}
