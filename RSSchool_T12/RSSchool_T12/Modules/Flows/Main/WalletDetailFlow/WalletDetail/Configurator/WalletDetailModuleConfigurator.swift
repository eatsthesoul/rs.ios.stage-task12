//
//  WalletDetailModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class WalletDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (WalletDetailViewController, WalletDetailModuleOutput) {
        
        let nibName = WalletDetailViewController.nibName
        let view = WalletDetailViewController(nibName: nibName, bundle: nil)
        
        let presenter = WalletDetailPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
