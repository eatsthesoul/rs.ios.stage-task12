//
//  TransactionTypeCellViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21.02.22.
//

import UIKit

struct TransactionTypeCellViewModel {
    
    let title: String
    let image: UIImage
    
    init(with transactionType: TransactionType) {
        title = transactionType.name
        image = transactionType.image
    }
}
