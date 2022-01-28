//
//  Currency.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 28.01.22.
//

import Foundation

enum Currency {
    
    static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static func localCode() -> String {
        Locale.current.currencyCode ?? "USD"
    }
    
    static func allCodes() -> [String] {
        Locale.isoCurrencyCodes
    }
    
    static func name(for currencyCode: String) -> String {
        Locale.current.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }
    
    static func symbol(for currencyCode: String) -> String {
        let localeIdentifier = Locale.current.identifier
        let locale = NSLocale(localeIdentifier: localeIdentifier)
        return locale.displayName(forKey: .currencySymbol, value: currencyCode) ?? currencyCode
    }
    
    static func formattedString(for number: Decimal, currencyCode: String) -> String? {
        
        let symbol = symbol(for: currencyCode)
        
        let numberFormatter = numberFormatter
        numberFormatter.currencySymbol = symbol
        
        return numberFormatter.string(from: NSDecimalNumber(decimal: number))
    }
}
