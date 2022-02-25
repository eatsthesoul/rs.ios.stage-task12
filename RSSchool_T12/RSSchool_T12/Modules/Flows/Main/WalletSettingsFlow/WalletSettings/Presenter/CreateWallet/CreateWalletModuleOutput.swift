//
//  CreateWalletModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CreateWalletModuleOutput: AnyObject {
    var showColorThemeList: CompletionBlock? { get set }
    var showCurrencyList: Closure<String>? { get set }
    var didDismiss: CompletionBlock? { get set }
    var didGetFillRequiredFieldsWarning: CompletionBlock? { get set }
    var didShowNameUsedWarning: CompletionBlock? { get set }
    var didShowCreateWalletMessage: CompletionBlock? { get set }
}
