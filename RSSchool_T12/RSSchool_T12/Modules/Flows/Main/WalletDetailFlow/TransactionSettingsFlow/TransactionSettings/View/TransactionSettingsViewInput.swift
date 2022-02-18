//
//  TransactionSettingsViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionSettingsViewInput: AnyObject {
    //title for navigation bar
    func setupInitialState(with title: String, transaction: TransactionSettingsViewModel)
}
