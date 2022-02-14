//
//  WalletDetailViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import UIKit

final class WalletDetailViewController: UIViewController, WalletDetailViewInput {
    
    // MARK: - Properties
    
    static let nibName = "WalletDetailViewController"

    var output: WalletDetailViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - WalletDetailViewInput

    func setupInitialState() {

    }
}
