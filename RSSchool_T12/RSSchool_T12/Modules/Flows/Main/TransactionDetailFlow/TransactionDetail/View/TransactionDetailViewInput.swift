//
//  TransactionDetailViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionDetailViewInput: AnyObject {
    func setup(transaction: TransactionDetailViewModel)
}
