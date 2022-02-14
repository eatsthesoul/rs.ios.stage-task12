//
//  WalletListViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletListViewOutput {
    func viewLoaded() // Notify presenter that view is ready
    func viewWillAppear() // Notify presenter that view will appear
    func rightNavigationBarTapped()
    func didSelectWallet(with index: Int)
}
