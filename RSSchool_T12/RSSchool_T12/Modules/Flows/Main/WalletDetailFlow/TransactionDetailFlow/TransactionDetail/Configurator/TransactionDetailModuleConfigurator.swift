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

    func configure(with transaction: Transaction, wallet: Wallet) -> (TransactionDetailViewController, TransactionDetailModuleOutput) {
        
        let nibName = TransactionDetailViewController.nibName
        let view = TransactionDetailViewController(nibName: nibName, bundle: nil)
        
        let presenter = TransactionDetailPresenter(transaction: transaction, wallet: wallet)

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
