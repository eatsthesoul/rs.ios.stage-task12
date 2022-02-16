//
//  WalletCellViewModel.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import Foundation

struct WalletCellViewModel {
    let title: String
    let balance: String
    let lastChangeDate: String
    
    init(title: String, balance: String, lastChangeDate: Date?) {
        self.title = title
        self.balance = balance
        
        let dateString = lastChangeDate?.string(with: "MMMM d, yyyy") ?? "New"
        self.lastChangeDate = dateString
    }
}
