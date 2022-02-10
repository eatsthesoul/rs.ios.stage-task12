//
//  AlertViewController.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 9.02.22.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - Nested types
    
    enum Constants {
        static let nibName = "AlertViewController"
    }
    
    var didLeftButtonTapped: CompletionBlock?
    var didRightButtonTapped: CompletionBlock?

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var alertTitle = ""
    var alertMessage = ""
    var leftButtonTitle = ""
    var rightButtonTitle = ""
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        didLeftButtonTapped?()
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        didRightButtonTapped?()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupView()
    }
    
    func setupView() {
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        leftButton.setTitle(leftButtonTitle, for: .normal)
        rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    private func setupAppearance() {
        rightButton.titleLabel?.font = UIFont.montserrat(17, .regular)
        leftButton.titleLabel?.font = UIFont.montserrat(17, .regular)
        
        alertView.makeGlassBackground(with: 20)
        rightButton.makeGlassBackground(with: 20)
        leftButton.makeGlassBackground(with: 20)
    }

}
