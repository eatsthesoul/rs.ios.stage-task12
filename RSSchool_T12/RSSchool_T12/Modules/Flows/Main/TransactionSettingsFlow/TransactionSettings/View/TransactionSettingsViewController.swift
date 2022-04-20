//
//  TransactionSettingsViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import UIKit

final class TransactionSettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: TextField!
    
    @IBOutlet weak var changeTextField: TextField!
    @IBOutlet weak var changeSegmentedControl: TransactionSegmentedControl!
    
    @IBOutlet weak var typePanel: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var noteTextView: TextView!

    // MARK: - Properties

    static let nibName = "TransactionSettingsViewController"
    var output: TransactionSettingsViewOutput?
    
    // MARK: - Private properties
    
    private let keyboardMargin: CGFloat = 40
    private var activeField: UIView? = nil

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTextViews()
        setupChangeSegmentedControl()
        addGestureRegognizers()
        addNavigationBarButtonsHandlers()
        registerForKeyboardNotifications()
        
        output?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output?.viewWillAppear()
    }
}

// MARK: - TransactionSettingsViewInput

extension TransactionSettingsViewController: TransactionSettingsViewInput {
    
    func setupInitialState(with title: String) {
        navigationBar.title = title
    }
    
    func setupView(with transaction: TransactionSettingsViewModel) {
        titleTextField.text = transaction.title
        changeTextField.text = transaction.change
        typeImageView.image = transaction.type.image
        typeLabel.text = transaction.type.name
        noteTextView.text = transaction.note
        changeSegmentedControl.isOutcome = transaction.isOutcome
    }
}

// MARK: - Private methods

private extension TransactionSettingsViewController {
    
    func setupAppearance() {
        view.makeThemeBackground()
        typeImageView.makeBorderBackground(with: 10)
    }
    
    func setupTextViews() {
        titleTextField.delegate = self
        changeTextField.delegate = self
        noteTextView.delegate = self
        
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        changeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupChangeSegmentedControl() {
        changeSegmentedControl.addTarget(self, action: #selector(segmentedControlValueDidChange), for: .valueChanged)
    }
    
    func addGestureRegognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let typePanelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(typePanelTapHandler))
        typePanel.addGestureRecognizer(typePanelTapGestureRecognizer)
    }
    
    func addNavigationBarButtonsHandlers() {
        navigationBar.leftButtonHandler = output?.leftNavigationBarButtonTapped
    }
}

// MARK: - Handlers

private extension TransactionSettingsViewController {
    
    @objc func typePanelTapHandler() {
        output?.didTapOnTypePanel()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == titleTextField, let text = textField.text {
            output?.transactionTitleDidUpdate(text)
        }
        
        if  textField == changeTextField,
            let text = textField.text
        {
                output?.transactionSumDidUpdate(text)
        }
    }
    
    @objc func segmentedControlValueDidChange() {
        let value = changeSegmentedControl.isOutcome
        output?.isOutcomeDidUpdate(value)
    }
}

// MARK: - Keyboard methods

private extension TransactionSettingsViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        guard let activeField = activeField else { return }
        let bottomOfTextField = activeField.convert(activeField.bounds, to: self.view).maxY;
        let topOfKeyboard = self.view.frame.height - keyboardSize.height
        let textFieldAndKeyboardDifference = topOfKeyboard - bottomOfTextField - keyboardMargin
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.scrollView.contentInset = insets
        
        if textFieldAndKeyboardDifference < 0 {
            
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

extension TransactionSettingsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate

extension TransactionSettingsViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.activeField = textView
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeField = nil
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == noteTextView, let text = textView.text {
            output?.transactionNoteDidUpdate(text)
        }
    }
}

