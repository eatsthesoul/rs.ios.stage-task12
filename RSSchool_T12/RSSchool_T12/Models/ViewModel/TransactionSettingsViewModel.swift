//
//  TransactionSettingsViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import Foundation

struct TransactionSettingsViewModel: Equatable {
    var title: String
    var change: String
    var isOutcome: Bool
    var note: String?
    var type: TransactionType
}

extension TransactionSettingsViewModel {
    
    init(_ transaction: Transaction) {
        title = transaction.title
        change = "\(transaction.sum)"
        isOutcome = transaction.isOutcome
        note = transaction.note
        type = transaction.type
    }
}
