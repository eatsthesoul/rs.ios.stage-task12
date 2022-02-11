//
//  WalletListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class WalletListPresenter: WalletListViewOutput, WalletListModuleInput, WalletListModuleOutput {

    // MARK: - WalletListModuleOutput

    // MARK: - Properties

    weak var view: WalletListViewInput?

    // MARK: - WalletListViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - WalletListModuleInput

}
