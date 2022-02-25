//
//  EditTransactionModuleInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 23.02.22.
//


protocol EditTransactionModuleInput: AnyObject {
    //this method calls from Alert asking for edit transaction permission (calls if answer is positive)
    func editTransaction()
}
