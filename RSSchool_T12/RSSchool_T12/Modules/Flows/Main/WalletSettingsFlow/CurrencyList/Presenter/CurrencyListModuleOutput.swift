//
//  CurrencyListModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 27/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CurrencyListModuleOutput: AnyObject {
    var didDismissWithCurrency: Closure<String>? { get set }
}
