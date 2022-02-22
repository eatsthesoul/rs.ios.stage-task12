//
//  TransactionSettingsCoordinatorOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import Foundation

protocol TransactionSettingsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
