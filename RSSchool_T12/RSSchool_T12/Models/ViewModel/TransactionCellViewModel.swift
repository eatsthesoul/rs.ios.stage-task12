//
//  TransactionCellViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16.02.22.
//

import Foundation
import UIKit

struct TransactionCellViewModel {
    let image: UIImage
    let name: String
    let date: String
    let sum: String
    let isOutcome: Bool
    
    init(with transaction: Transaction) {
        image = transaction.type.image
        name = transaction.title
        date = transaction.date.string(with: "d MMM")
        isOutcome = transaction.isOutcome
        
        let sum = transaction.sum.decimalValue
        let currencyCode = transaction.wallet?.currencyCode ?? ""
        let transactionSum = Currency.formattedString(for: sum, currencyCode: currencyCode) ?? "0"
        self.sum = isOutcome ? ("-" + transactionSum) : transactionSum
    }    
}
