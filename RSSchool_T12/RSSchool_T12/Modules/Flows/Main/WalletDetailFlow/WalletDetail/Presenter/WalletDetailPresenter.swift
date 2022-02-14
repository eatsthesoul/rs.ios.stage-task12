//
//  WalletDetailPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class WalletDetailPresenter: WalletDetailViewOutput, WalletDetailModuleInput, WalletDetailModuleOutput {

    // MARK: - WalletDetailModuleOutput

    // MARK: - Properties

    weak var view: WalletDetailViewInput?

    // MARK: - WalletDetailViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - WalletDetailModuleInput

}
