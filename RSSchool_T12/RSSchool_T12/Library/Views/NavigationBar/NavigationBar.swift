//
//  NavigationBar.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 13.01.22.
//

import UIKit

class NavigationBar: UIView {
    
    private let nibName = "NavigationBar"
    var view: UIView!
    
    @IBOutlet weak var leftButton: BarButton!
    @IBOutlet weak var rightButton: BarButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var leadingTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingTitleConstraint: NSLayoutConstraint!
    
    var leftButtonHandler: CompletionBlock?
    var rightButtonHandler: CompletionBlock?
    
    @IBInspectable var leftButtonStyle: Int {
        get { leftButton.style.rawValue }
        set { leftButton.style = BarButton.Style(rawValue: newValue) ?? .normal }
    }
    
    @IBInspectable var rightButtonStyle: Int {
        get { rightButton.style.rawValue }
        set { rightButton.style = BarButton.Style(rawValue: newValue) ?? .normal }
    }

    @IBInspectable var leftButtonImage: UIImage? {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.isHidden = leftButtonImage == nil
            leftButton.setImage(leftButtonImage?.withTintColor(.deepSaffron), for: .highlighted)
            setupButtons()
        }
    }

    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
            rightButton.isHidden = (rightButtonImage == nil)
            rightButton.setImage(rightButtonImage?.withTintColor(.deepSaffron), for: .highlighted)
            setupButtons()
        }
    }
    
    @IBInspectable var title: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        makeGlassBackground(with: 20)
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        makeGlassBackground(with: 20)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupButtons()
    }
    
    // MARK: - IBActions
    
    @IBAction func leftButtonAction(_ sender: Any) {
        leftButtonHandler?()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        rightButtonHandler?()
    }
}

// MARK: - Private methods

private extension NavigationBar {
    
    func setupButtons() {
        setupButtonsConstraints()
        setupButtonsVisibility()
    }
    
    func setupButtonsConstraints() {
        leadingTitleConstraint.constant = leftButtonImage == nil ? 30 : 90
        trailingTitleConstraint.constant = rightButtonImage == nil ? 30 : 90
    }
    
    func setupButtonsVisibility() {
        leftButton.isHidden = leftButtonImage == nil
        rightButton.isHidden = rightButtonImage == nil
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
