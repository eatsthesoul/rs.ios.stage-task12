//
//  TransactionTypeListModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionTypeListModuleConfigurator {

    // MARK: - Internal methods

    func configure(with selectedType: TransactionType) -> (TransactionTypeListViewController, TransactionTypeListModuleOutput) {
        
        let view = TransactionTypeListViewController()
        let presenter = TransactionTypeListPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
