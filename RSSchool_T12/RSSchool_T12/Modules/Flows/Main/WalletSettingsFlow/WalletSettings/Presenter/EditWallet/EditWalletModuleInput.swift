//
//  EditWalletModuleInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.02.22.
//

protocol EditWalletModuleInput: AnyObject {
    //this method calls from Alert asking for edit wallet permission (calls if answer is positive)
    func editWallet()
    //this method calls from Alert asking for delete wallet permission (calls if answer is positive)
    func deleteWallet()
}
