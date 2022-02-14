//
//  WalletCoordinatorOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import Foundation

protocol WalletCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
