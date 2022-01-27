//
//  CurrencyListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class CurrencyListViewController: UIViewController, CurrencyListViewInput {

    // MARK: - Properties

    var output: CurrencyListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.makeThemeBackground()
    }

    // MARK: - CurrencyListViewInput

    func setupInitialState() {

    }

}
