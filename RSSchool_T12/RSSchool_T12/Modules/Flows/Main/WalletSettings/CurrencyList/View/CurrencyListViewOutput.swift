//
//  CurrencyListViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CurrencyListViewOutput {
    func viewLoaded() // Notify presenter that view is ready
    func leftNavigationBarButtonTapped()
    func didSelectCurrency(with index: Int)
}
