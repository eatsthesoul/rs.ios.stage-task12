//
//  TransactionDetailViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22.02.22.
//

import UIKit

final class TransactionDetailViewController: UIViewController {

    // MARK: - Properties
    
    static let nibName = "TransactionDetailViewController"
    var output: TransactionDetailViewOutput?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        
        setupAppearance()
        setupNavigationBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    // MARK: - IBActions
    
    @IBAction func editTransaction(_ sender: Any) {
        output?.editTransaction()
    }
    
    @IBAction func deleteTransaction(_ sender: Any) {
        output?.deleteTransaction()
    }
    
}

//MARK: - Private methods

private extension TransactionDetailViewController {
    
    func setupAppearance() {
        view.makeThemeBackground()
    }
    
    func setupNavigationBarButtons() {
        navigationBar.leftButtonHandler = output?.leftNavigationBarButtonTapped
    }
}

// MARK: - TransactionDetailViewInput

extension TransactionDetailViewController: TransactionDetailViewInput {
    
    func setup(transaction: TransactionDetailViewModel) {
        
        navigationBar.title = transaction.date
        titleLabel.text = transaction.name
        changeLabel.text = transaction.change
        noteLabel.text = transaction.note
        
        changeLabel.textColor = transaction.isOutcome ? .amaranthRed : .celadon
    }
}
