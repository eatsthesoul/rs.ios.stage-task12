//
//  TransactionTypeListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class TransactionTypeListPresenter: TransactionTypeListModuleInput, TransactionTypeListModuleOutput {

    // MARK: - TransactionTypeListModuleOutput
    
    var didDismissWithType: Closure<TransactionType>?

    // MARK: - Properties
    
    weak var view: TransactionTypeListViewInput?
    
    // MARK: - Private properties
    
    private let transactionTypes: [TransactionType]
    
    private var selectedType: TransactionType = .other
    
    private var selectedTypeIndex: Int? {
        willSet {
            guard let newValue = newValue else { return }
            selectedType = transactionTypes[newValue]
        }
    }
    
    // MARK: - Initialization and deinitialization
    
    init(with selectedType: TransactionType) {
        transactionTypes = TransactionType.allCases
        
        //if we set selected type index we also set selected type because of KVO
        selectedTypeIndex = transactionTypes.firstIndex(of: selectedType)
    }
}

// MARK: - TransactionTypeListViewOutput

extension TransactionTypeListPresenter: TransactionTypeListViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState(with: "Transaction types")
        setupView()
    }
    
    func leftNavigationBarButtonTapped() {
        didDismissWithType?(selectedType)
    }
    
    func didSelectType(with index: Int) {
        selectedTypeIndex = index
    }
}

// MARK: - Private methods

private extension TransactionTypeListPresenter {
    
    //setup view with transaction types
    func setupView() {
        
        var cellViewModels = [TransactionTypeCellViewModel]()
        transactionTypes.forEach { transactionType in
            let cellViewModel = TransactionTypeCellViewModel(with: transactionType)
            cellViewModels.append(cellViewModel)
        }
        view?.setup(items: cellViewModels, with: selectedTypeIndex)
    }
}
