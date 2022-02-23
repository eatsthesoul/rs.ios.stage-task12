//
//  EditTransactionModuleOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 23.02.22.
//


protocol EditTransactionModuleOutput: AnyObject {
    var showTransactionTypeList: Closure<TransactionType>? { get set }
    var didShowEditTransactionMessage: CompletionBlock? { get set }
    var didDismiss: CompletionBlock? { get set }
    var didGetTitleWarning: CompletionBlock? { get set }
    var didGetSumWarning: CompletionBlock? { get set }
    var didGetNoteWarning: CompletionBlock? { get set }
}
