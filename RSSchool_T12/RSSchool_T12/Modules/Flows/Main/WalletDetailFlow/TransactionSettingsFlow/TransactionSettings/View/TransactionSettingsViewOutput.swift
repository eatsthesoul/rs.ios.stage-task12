//
//  TransactionSettingsViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17/02/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import Foundation

protocol TransactionSettingsViewOutput {
    func viewLoaded()
    func leftNavigationBarButtonTapped()
    func didTapOnTypePanel()
    func transactionTitleDidUpdate(_ string: String)
    func transactionSumDidUpdate(_ sum: String)
    func isOutcomeDidUpdate(_ bool: Bool)
    func transactionNoteDidUpdate(_ string: String)
}
