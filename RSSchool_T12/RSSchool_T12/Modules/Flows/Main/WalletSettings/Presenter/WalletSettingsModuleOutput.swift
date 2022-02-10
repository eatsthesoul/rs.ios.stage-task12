//
//  WalletSettingsModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletSettingsModuleOutput: AnyObject {
    var showColorThemeList: CompletionBlock? { get set }
    var showCurrencyList: Closure<String>? { get set }
    var didGetFillRequiredFieldsWarning: CompletionBlock? { get set }
    var didNameUsedWarning: CompletionBlock? { get set }
}
