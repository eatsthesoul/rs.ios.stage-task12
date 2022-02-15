//
//  TransactionSettingsViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import Foundation

struct TransactionSettingsViewModel {
    let title: String
    let change: Decimal
    let isOutcome: Bool
    let note: String
    let type: TransactionType
}
