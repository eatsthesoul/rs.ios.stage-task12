//
//  TransactionTypeListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionTypeListPresenter: TransactionTypeListViewOutput, TransactionTypeListModuleInput, TransactionTypeListModuleOutput {

    // MARK: - TransactionTypeListModuleOutput

    // MARK: - Properties

    weak var view: TransactionTypeListViewInput?

    // MARK: - TransactionTypeListViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - TransactionTypeListModuleInput

}
