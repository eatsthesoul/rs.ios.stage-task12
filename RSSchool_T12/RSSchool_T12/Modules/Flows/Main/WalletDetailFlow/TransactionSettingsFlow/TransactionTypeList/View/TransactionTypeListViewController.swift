//
//  TransactionTypeListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class TransactionTypeListViewController: UIViewController, TransactionTypeListViewInput {

    // MARK: - Properties

    var output: TransactionTypeListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - TransactionTypeListViewInput

    func setupInitialState() {

    }

}
