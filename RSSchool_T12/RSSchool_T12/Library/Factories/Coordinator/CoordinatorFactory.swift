//
//  CoordinatorFactory.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import UIKit

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

// MARK: - CoordinatorFactoryProtocol
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(with: modulesFactory, router: router)
    }
}
