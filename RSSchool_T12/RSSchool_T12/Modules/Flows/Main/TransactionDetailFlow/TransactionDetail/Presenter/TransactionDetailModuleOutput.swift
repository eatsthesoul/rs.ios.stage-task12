//
//  TransactionDetailModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol TransactionDetailModuleOutput: AnyObject {
    var didDismiss: CompletionBlock? { get set }
    var didShowEditTransaction: Closure<Transaction>? { get set }
    var didShowDeleteTransactionMessage: CompletionBlock? { get set }
}
