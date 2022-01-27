//
//  CurrencyListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CurrencyListPresenter: CurrencyListViewOutput, CurrencyListModuleInput, CurrencyListModuleOutput {

    // MARK: - CurrencyListModuleOutput

    // MARK: - Properties

    weak var view: CurrencyListViewInput?

    // MARK: - CurrencyListViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - CurrencyListModuleInput

}
