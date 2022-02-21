//
//  CreateTransactionModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CreateTransactionModuleOutput: AnyObject {
    var showTransactionTypeList: Closure<TransactionType>? { get set }
}
