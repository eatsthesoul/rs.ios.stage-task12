//
//  WalletDetailViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletDetailViewInput: AnyObject {
    func setupInitialState(with walletName: String)
    func setup(items: [TransactionCellViewModel]) //set collection view items
    func setup(balance: String?)
}
