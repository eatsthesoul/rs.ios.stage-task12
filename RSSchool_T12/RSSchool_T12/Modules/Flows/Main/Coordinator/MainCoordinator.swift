//
//  MainCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: MainFactoryProtocol
    fileprivate let router: Routable
    
    init(with factory: MainFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router  = router
    }
}

// MARK: - Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
private extension MainCoordinator {
    func performFlow() {
        
    }
}
