//
//  Router.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import UIKit

final class Router: NSObject {

    // MARK: - Private variables
    
    private var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate)?.window
    }

    private var navigationController: UINavigationController? {
        if let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            return tabBar.selectedViewController as? UINavigationController
        }
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }

    private var tabBarController: UITabBarController? {
        return UIApplication.shared.windows.first?.rootViewController as? UITabBarController
    }

    private var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }
}

// MARK: - Routable
extension Router: Routable {
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool, completion: CompletionBlock? = nil) {
        guard let controller = module?.toPresent() else { return }
        topViewController?.present(controller, animated: animated, completion: completion)
    }

    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        topViewController?.navigationController?.pushViewController(controller, animated: animated)
    }

    func popModule()  {
        popModule(animated: true)
    }

    func popModule(animated: Bool)  {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRootModule(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?) {
        window?.rootViewController = module?.toPresent()
    }

    func setNavigationControllerRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        navigationController?.isNavigationBarHidden = hideBar
        navigationController?.setViewControllers([controller], animated: false)
    }
}
