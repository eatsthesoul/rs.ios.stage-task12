//
//  CurrencyCellViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 1.02.22.
//

import Foundation

struct CurrencyCellViewModel {
    
    let code: String
    let name: String
    
    init(with code: String) {
        //code
        self.code = code
        //name
        let name = Currency.name(for: code)
        self.name = name
    }
}
