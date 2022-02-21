//
//  TransactionSegmentedControl.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21.02.22.
//

import UIKit

class TransactionSegmentedControl: UIControl {
    
    private let selectorMargin: CGFloat = 2
    
    private lazy var buttonsArray = [outcomeButton, incomeButton]
    
    //outcome by default
    var isOutcome: Bool = true {
        didSet {
            updateSelectorView()
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Views
    
    //view for highlighting selected button
    lazy var selectorView: UIView = {
        let view = UIView()
        let height = bounds.height - 2 * selectorMargin
        let width = bounds.width / 2 - 2 * selectorMargin
        view.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        view.makeGlassBackground(with: 8)
        return view
    }()
    
    lazy var outcomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Outcome", for: .normal)
        button.titleLabel?.font = .montserrat(13, .medium)
        button.setTitleColor(.amaranthRed, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var incomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Income", for: .normal)
        button.titleLabel?.font = .montserrat(13, .medium)
        button.setTitleColor(.celadon, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    //stack view for segmented control buttons
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttonsArray)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization and deinitialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        addSubviews()
        setupLayout()
        addTargetsForButtons()
        updateSelectorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
        addSubviews()
        setupLayout()
        addTargetsForButtons()
        updateSelectorView()
    }
}

// MARK: - Private methods

private extension TransactionSegmentedControl {
    
    func setupAppearance() {
        makeGlassBackground(with: 10)
    }
    
    func addSubviews() {
        addSubview(selectorView)
        addSubview(stackView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func addTargetsForButtons() {
        outcomeButton.addTarget(self, action: #selector(outcomeButtonTapped), for: .touchUpInside)
        incomeButton.addTarget(self, action: #selector(incomeButtonTapped), for: .touchUpInside)
    }
    
    func updateSelectorView() {
        
        let buttonIndex = isOutcome ? 0 : 1
        let buttonWidth = bounds.width / CGFloat(buttonsArray.count)
        
        let xOrigin: CGFloat = CGFloat(buttonIndex) * buttonWidth + selectorMargin
        let yOrigin: CGFloat = selectorMargin
        
        selectorView.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
    }
}

// MARK: - Handlers

extension TransactionSegmentedControl {
    
    @objc func outcomeButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.isOutcome = true
        }
    }
    
    @objc func incomeButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.isOutcome = false
        }
    }
}
