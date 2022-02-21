//
//  TransactionTypeListViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionTypeListViewOutput {
    func viewLoaded()
    func leftNavigationBarButtonTapped()
    func didSelectType(with index: Int)
}
