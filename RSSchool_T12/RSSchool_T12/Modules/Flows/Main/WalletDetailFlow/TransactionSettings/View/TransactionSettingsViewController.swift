//
//  TransactionSettingsViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import UIKit

final class TransactionSettingsViewController: UIViewController, TransactionSettingsViewInput {

    // MARK: - Properties

    static let nibName = "TransactionSettingsViewController"
    
    var output: TransactionSettingsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - TransactionSettingsViewInput

    func setupInitialState() {

    }

}

