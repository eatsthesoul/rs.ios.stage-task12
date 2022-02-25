//
//  EditWalletModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.02.22.
//

protocol EditWalletModuleOutput: AnyObject {
    var showColorThemeList: CompletionBlock? { get set }
    var showCurrencyList: Closure<String>? { get set }
    var didDismiss: CompletionBlock? { get set }
    var didShowEditWalletMessage: CompletionBlock? { get set }
    var didGetFillRequiredFieldsWarning: CompletionBlock? { get set }
    var didShowNameUsedWarning: CompletionBlock? { get set }
    var didShowDeleteWalletMessage: CompletionBlock? { get set }
}
