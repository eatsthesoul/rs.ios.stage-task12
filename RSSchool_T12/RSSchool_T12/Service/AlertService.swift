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
    
}
