//
//  WalletListPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class WalletListPresenter: WalletListViewOutput, WalletListModuleInput, WalletListModuleOutput {

    // MARK: - WalletListModuleOutput
    
    var didCreateNewWallet: CompletionBlock?
    var didSelectWallet: Closure<Wallet>?

    // MARK: - Properties

    weak var view: WalletListViewInput?
    let dataStoreManager: DataStoreProtocol
    
    // MARK: - Private properties
    
    var wallets: [Wallet] {
        didSet {
            updateWalletsOnView()
        }
    }
    
    // MARK: - Initialization and deinitialization
    
    init(storeManager: DataStoreProtocol) {
        dataStoreManager = storeManager
        wallets = []
    }
}

// MARK: - WalletListViewOutput

extension WalletListPresenter {
    
    func viewLoaded() {
        
    }
    
    func viewWillAppear() {
        fetchWallets()
    }
    
    func rightNavigationBarTapped() {
        didCreateNewWallet?()
    }
    
    func didSelectWallet(with index: Int) {
        let wallet = wallets[index]
        didSelectWallet?(wallet)
    }
}

// MARK: - Private methods

extension WalletListPresenter {
    
    func fetchWallets() {
        wallets = dataStoreManager.fetchWallets()
    }
    
    //this method will be called every time wallets are updated
    func updateWalletsOnView() {
        
        var viewModels = [WalletCellViewModel]()
        
        wallets.forEach { wallet in
            
            let walletBalance = dataStoreManager.totalBalance(for: wallet)
            let balance = Currency.formattedString(for: walletBalance, currencyCode: wallet.currencyCode) ?? ""
            let lastDate = dataStoreManager.lastChangeDate(for: wallet)
            
            let viewModel = WalletCellViewModel(title: wallet.title, balance: balance, lastChangeDate: lastDate)
            viewModels.append(viewModel)
        }
        
        view?.setup(items: viewModels)
    }
}
