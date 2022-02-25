//
//  WalletData.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 7.02.22.
//

import Foundation
import CoreData

struct WalletSettingsViewModel: Equatable {
    
    var colorTheme: ColorTheme
    var currencyCode: String
    var title: String
}

extension WalletSettingsViewModel {
    
    init(_ wallet: Wallet) {
        colorTheme = wallet.colorTheme
        currencyCode = wallet.currencyCode
        title = wallet.title
    }
}
