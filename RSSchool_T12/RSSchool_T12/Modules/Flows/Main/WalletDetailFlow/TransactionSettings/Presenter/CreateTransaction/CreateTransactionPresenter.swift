//
//  CreateTransactionPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CreateTransactionPresenter: TransactionSettingsViewOutput, CreateTransactionModuleInput, CreateTransactionModuleOutput {

    // MARK: - TransactionSettingsModuleOutput

    // MARK: - Properties

    weak var view: TransactionSettingsViewInput?
    
    let dataStoreManager: DataStoreProtocol
    
    // MARK: - Initialization and deinitialization
    
    init(dataStoreManager: DataStoreProtocol) {
        self.dataStoreManager = dataStoreManager
    }

    // MARK: - TransactionSettingsViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - TransactionSettingsModuleInput

}
