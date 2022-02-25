//
//  WalletSettingsCoordinatorOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import Foundation

protocol WalletSettingsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
    var finishFlowWithDeletingWallet: CompletionBlock? { get set }
}
