//
//  CreateWalletModuleInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.02.22.
//

protocol CreateWalletModuleInput: AnyObject {
    //this method calls from Alert asking for save(create) wallet permission (calls if answer is positive)
    func saveWallet()
}
