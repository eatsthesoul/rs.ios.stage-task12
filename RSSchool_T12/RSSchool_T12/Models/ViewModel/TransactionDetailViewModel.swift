//
//  TransactionDetailViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22.02.22.
//

import Foundation


struct TransactionDetailViewModel {
    
    let name: String
    let change: String
    let isOutcome: Bool
    let date: String
    let note: String?
    
    init(with transaction: Transaction) {
        
        name = transaction.title
        isOutcome = transaction.isOutcome
        date = transaction.date.string(with: "MMMM d, yyyy")
        note = transaction.note
        
        let sum = transaction.sum.decimalValue
        let currencyCode = transaction.wallet?.currencyCode ?? ""
        let transactionSum = Currency.formattedString(for: sum, currencyCode: currencyCode) ?? "0"
        change = isOutcome ? ("-" + transactionSum) : transactionSum
    }
}
