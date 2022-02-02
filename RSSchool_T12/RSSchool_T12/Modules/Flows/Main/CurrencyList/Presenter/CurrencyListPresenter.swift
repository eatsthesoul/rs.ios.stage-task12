//
//  CurrencyListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CurrencyListPresenter: CurrencyListViewOutput, CurrencyListModuleInput, CurrencyListModuleOutput {
    
    // MARK: - CurrencyListModuleOutput
    
    var didDismissWithCurrency: Closure<String>?
    
    // MARK: - Properties
    
    weak var view: CurrencyListViewInput?
    
    
    // MARK: - Private properties
    
    private let title = "Wallet currency"
    private let currencyCodes: [String]
    private let currencyCellViewModels: [CurrencyCellViewModel]
    
    private var selectedCurrency: String?
    private var selectedCurrencyIndex: Int? {
        willSet {
            guard let newValue = newValue else { return }
            selectedCurrency = currencyCodes[newValue]
        }
    }
    
    // MARK: - Initialization and deinitialization
    
    init(with selectedCurrency: String) {
        currencyCodes = Currency.allCodes()
        
        selectedCurrencyIndex = currencyCodes.firstIndex(of: selectedCurrency)
        self.selectedCurrency = selectedCurrency
        
        //currencyCellViewModels
        var currencyCellViewModels = [CurrencyCellViewModel]()
        currencyCodes.forEach { currencyCellViewModels.append(CurrencyCellViewModel(with: $0)) }
        self.currencyCellViewModels = currencyCellViewModels
    }
    
    // MARK: - CurrencyListModuleInput

}

// MARK: - CurrencyListViewOutput

extension CurrencyListPresenter {
    func viewLoaded() {
        view?.setupInitialState(with: title)
        view?.setup(items: currencyCellViewModels, with: selectedCurrencyIndex)
    }
    
    func leftNavigationBarButtonTapped() {
        didDismissWithCurrency?(selectedCurrency ?? "USD")
    }
    
    func didSelectCurrency(with index: Int) {
        selectedCurrencyIndex = index
    }
}
