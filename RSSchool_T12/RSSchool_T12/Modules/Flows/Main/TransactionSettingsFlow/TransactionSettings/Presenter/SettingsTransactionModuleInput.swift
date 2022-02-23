//
//  SettingsTransactionModuleInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 23.02.22.
//


protocol SettingsTransactionModuleInput: AnyObject {
    func set(transactionType: TransactionType)
}

