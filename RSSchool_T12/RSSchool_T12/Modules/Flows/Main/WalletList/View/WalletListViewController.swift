//
//  WalletListViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import UIKit

final class WalletListViewController: UIViewController, WalletListViewInput {
    
    // MARK: - Nested types
    
    enum Constants {
        static let nibName = "WalletListViewController"
    }

    // MARK: - Properties

    var output: WalletListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - WalletListViewInput

    func setupInitialState() {

    }
}
