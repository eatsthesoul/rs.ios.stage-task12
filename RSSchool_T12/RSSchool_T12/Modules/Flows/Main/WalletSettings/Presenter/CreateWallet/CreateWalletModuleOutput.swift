//
//  CreateWalletModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CreateWalletModuleOutput: AnyObject {
    var showColorThemeList: CompletionBlock? { get set }
    var showCurrencyList: CompletionBlock? { get set }
}
