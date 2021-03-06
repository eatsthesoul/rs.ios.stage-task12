//
//  WalletDetailViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletDetailViewOutput {
    func viewLoaded()
    func viewWillAppear()
    func leftNavigationBarButtonTapped()
    func rightNavigationBarButtonTapped()
    func showAllTransactions()
    func addTransaction()
    func didSelectCollectionViewItem(with index: Int)
}
