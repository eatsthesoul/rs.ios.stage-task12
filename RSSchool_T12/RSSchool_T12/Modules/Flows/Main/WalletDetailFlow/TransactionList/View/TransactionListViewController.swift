//
//  TransactionListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionListViewController: UIViewController, TransactionListViewInput {

    // MARK: - Properties

    var output: TransactionListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - TransactionListViewInput

    func setupInitialState() {

    }

}
