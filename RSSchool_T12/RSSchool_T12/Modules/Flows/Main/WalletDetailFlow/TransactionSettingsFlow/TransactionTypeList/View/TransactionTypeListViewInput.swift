//
//  TransactionTypeListViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionTypeListViewInput: AnyObject {
    func setupInitialState(with title: String)
    func setup(items: [TransactionTypeCellViewModel], with selectedIndex: Int?)
}
