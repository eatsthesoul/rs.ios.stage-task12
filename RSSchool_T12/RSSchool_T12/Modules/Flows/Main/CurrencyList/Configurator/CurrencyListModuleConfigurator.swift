//
//  CurrencyListModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class CurrencyListModuleConfigurator {

    // MARK: - Internal methods

    func configure(with selectedCurrency: String) -> (CurrencyListViewController, CurrencyListModuleOutput) {
        let view = CurrencyListViewController()
        let presenter = CurrencyListPresenter(with: selectedCurrency)

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
