//
//  WalletListViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletListViewInput: AnyObject {
    func setup(items: [WalletCellViewModel])
}
