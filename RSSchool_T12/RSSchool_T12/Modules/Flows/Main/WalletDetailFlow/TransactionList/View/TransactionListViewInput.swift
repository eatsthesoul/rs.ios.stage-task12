//
//  TransactionListViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionListViewInput: AnyObject {
    func setup(items: [TransactionCellViewModel])
}
