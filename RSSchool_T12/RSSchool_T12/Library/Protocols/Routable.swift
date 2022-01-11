//
//  Routable.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import Foundation

protocol Routable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    
    func popModule()
    func popModule(animated: Bool)
    func popToRootModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func setRootModule(_ module: Presentable?)
    func setNavigationControllerRootModule(_ module: Presentable?, hideBar: Bool)
}
