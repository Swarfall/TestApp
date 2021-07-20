//
//  AppCoordinator.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigation = UINavigationController()
        self.window.rootViewController = navigation
    }
    
    func start() {
        let router = ListRouter(delegate: self)
        let viewController = router.build()
        navigation.setViewControllers([viewController], animated: true)
    }
}

// MARK: - Delegates
extension AppCoordinator: ListRouterDelegate {
    func showImageWith(url: URL) {
        let router = DetailRouter(url: url)
        let viewController = router.build()
        navigation.pushViewController(viewController, animated: true)
    }
}
