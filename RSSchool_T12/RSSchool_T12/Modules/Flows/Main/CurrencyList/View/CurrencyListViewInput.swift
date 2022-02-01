//
//  CurrencyListViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CurrencyListViewInput: AnyObject {
    
    func setupInitialState(with title: String) // Method for setup initial state of view
    func setup(items: [CurrencyCellViewModel], with selectedIndex: Int?)
}
