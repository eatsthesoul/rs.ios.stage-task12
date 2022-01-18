//
//  WalletSettingsViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

final class WalletSettingsViewController: UIViewController, WalletSettingsViewInput {

    // MARK: - Properties

    var output: WalletSettingsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - WalletSettingsViewInput

    func setupInitialState() {

    }

}
