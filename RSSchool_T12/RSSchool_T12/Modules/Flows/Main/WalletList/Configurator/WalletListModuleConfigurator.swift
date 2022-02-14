//
//  WalletListModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class WalletListModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (WalletListViewController, WalletListModuleOutput) {
        
        let view = WalletListViewController()
        
        let presenter = WalletListPresenter(storeManager: DataStoreManager())

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
