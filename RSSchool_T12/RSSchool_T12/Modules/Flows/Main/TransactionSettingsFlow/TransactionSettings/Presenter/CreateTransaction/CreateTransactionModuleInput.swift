//
//  CreateTransactionModuleInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol CreateTransactionModuleInput: AnyObject {
    //this method calls from Alert asking for save(create) transaction permission (calls if answer is positive)
    func saveTransaction()
}
