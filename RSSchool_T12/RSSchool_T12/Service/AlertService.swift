//
//  AlertConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 9.02.22.
//

import Foundation

class AlertService {
    
    func alert(title: String,
               message: String,
               leftButtonTitle: String,
               rightButtonTitle: String,
               leftButtonAction: CompletionBlock?,
               rightButtonAction: CompletionBlock?
    ) -> AlertViewController {
        
        let nibName = AlertViewController.Constants.nibName
        let alert = AlertViewController(nibName: nibName, bundle: nil)
        
        alert.alertTitle = title
        alert.alertMessage = message
        alert.leftButtonTitle = leftButtonTitle
        alert.rightButtonTitle = rightButtonTitle
        
        alert.didLeftButtonTapped = leftButtonAction
        alert.didRightButtonTapped = rightButtonAction
        
        return alert
    }
    
    func walletRequiredFieldsAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Warning!",
              message: "You have not filled in all required fields",
              leftButtonTitle: "Change",
              rightButtonTitle: "Back",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func walletNameIsExistAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Warning!",
              message: "This wallet name has already been used",
              leftButtonTitle: "Change",
              rightButtonTitle: "Back",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func createNewWalletAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "New Wallet",
              message: "Do you want to create a new wallet?",
              leftButtonTitle: "Yes",
              rightButtonTitle: "No",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func transactionTitleAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Warning!",
              message: "Title must contain more than 0 but not more than 20 characters",
              leftButtonTitle: "Change",
              rightButtonTitle: "Back",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func transactionSumAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Warning!",
              message: "Sum cannot be empty or equal to 0",
              leftButtonTitle: "Change",
              rightButtonTitle: "Back",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func transactionNoteAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Warning!",
              message: "Note must contain not more than 250 characters",
              leftButtonTitle: "Change",
              rightButtonTitle: "Back",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func createNewTransactionAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "New Transaction",
              message: "Do you want to create a new transaction?",
              leftButtonTitle: "Yes",
              rightButtonTitle: "No",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func deleteTransactionAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Delete transaction",
              message: "Are you sure you want to delete this transaction?",
              leftButtonTitle: "Cancel",
              rightButtonTitle: "Delete",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func editTransactionAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Edit Transaction",
              message: "Are you sure you want to edit this transaction?",
              leftButtonTitle: "Yes",
              rightButtonTitle: "No",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func editWalletAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Edit Wallet",
              message: "Are you sure you want to edit this wallet?",
              leftButtonTitle: "Yes",
              rightButtonTitle: "No",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
    
    func deleteWalletAlert(leftButtonAction: CompletionBlock?, rightButtonAction: CompletionBlock?) -> AlertViewController {
        alert(title: "Delete Wallet",
              message: "Are you sure you want to delete this wallet?",
              leftButtonTitle: "Yes",
              rightButtonTitle: "No",
              leftButtonAction: leftButtonAction,
              rightButtonAction: rightButtonAction)
    }
}
