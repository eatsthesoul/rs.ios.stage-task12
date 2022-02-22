//
//  TransactionDetailViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22.02.22.
//

import UIKit

final class TransactionDetailViewController: UIViewController, TransactionDetailViewInput {

    // MARK: - Properties
    
    static let nibName = "TransactionDetailViewController"
    var output: TransactionDetailViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - TransactionDetailViewInput

}
