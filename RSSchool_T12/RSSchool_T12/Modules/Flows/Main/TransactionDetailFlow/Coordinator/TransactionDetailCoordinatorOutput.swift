//
//  TransactionDetailCoordinatorOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 22.02.22.
//

import Foundation

protocol TransactionDetailCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
