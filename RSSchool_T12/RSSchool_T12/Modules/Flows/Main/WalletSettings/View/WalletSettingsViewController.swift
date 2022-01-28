//
//  WalletSettingsViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

final class WalletSettingsViewController: UIViewController, WalletSettingsViewInput {

    // MARK: - IBOutlets
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var colorThemePanel: GlassView!
    @IBOutlet weak var currencyPanel: GlassView!
    @IBOutlet weak var titleTextField: TextField!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    // MARK: - Properties

    var output: WalletSettingsViewOutput?
    
    // MARK: - Private properties
    
    private let keyboardMargin: CGFloat = 40
    private var activeTextField: UITextField? = nil

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        
        setupAppearance()
        addGestureRegognizers()
        addDelegateToTextFields()
        registerForKeyboardNotifications()
        addNavigationBarButtonsHandlers()
    }

    // MARK: - WalletSettingsViewInput
    
    func setupNewWalletInitialState(with barTitle: String, currency: String?) {
        navigationBar.title = barTitle
        currencyLabel.text = currency
    }
}

// MARK: - Private methods
private extension WalletSettingsViewController {
    
    func setupAppearance() {
        view.makeThemeBackground()
    }
    
    func addGestureRegognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let colorThemeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorThemePanelTapHandler))
        colorThemePanel.addGestureRecognizer(colorThemeTapGestureRecognizer)
        
        let currencyPanelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(currencyPanelTapHandler))
        currencyPanel.addGestureRecognizer(currencyPanelTapGestureRecognizer)
    }
    
    func addDelegateToTextFields() {
        titleTextField.delegate = self
    }
    
    func addNavigationBarButtonsHandlers() {
        navigationBar.leftButtonHandler = output?.leftNavigationBarButtonTapped
        navigationBar.rightButtonHandler = output?.rightNavigationBarButtonTapped
    }
    
    
}

// MARK: - Handlers
private extension WalletSettingsViewController {
    
    @objc func colorThemePanelTapHandler() {
        output?.didTapOnColorThemePanel()
    }
    
    @objc func currencyPanelTapHandler() {
        output?.didTapOnCurrencyPanel()
    }
}

// MARK: - Keyboard methods
private extension WalletSettingsViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        guard let activeTextField = activeTextField else { return }
        let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
        let topOfKeyboard = self.view.frame.height - keyboardSize.height
        let textFieldAndKeyboardDifference = topOfKeyboard - bottomOfTextField - keyboardMargin
        
        if textFieldAndKeyboardDifference < 0 {
            
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = insets
            
            let newXOffset = scrollView.contentOffset.x
            let newYOffset = scrollView.contentOffset.y - textFieldAndKeyboardDifference
            let contentOffset = CGPoint(x: newXOffset, y: newYOffset)
            
            UIView.animate(withDuration: 0.2) {
                self.scrollView.setContentOffset(contentOffset, animated: false)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension WalletSettingsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
