//
//  AppLaunchSceneDelegate.swift
//  Floofs
//

import UIKit

final class AppLaunchSceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var catsDataProvider: CatsDataProvider?
    private lazy var dogsDataProvider = DogsDataProvider()

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard
            let scene = (scene as? UIWindowScene),
            let apiKey = session.userInfo?.catsAPIKey
        else {
            return
        }
        window = UIWindow(windowScene: scene)

        let catsDataProvider = CatsDataProvider(apiKey: apiKey)
        self.catsDataProvider = catsDataProvider
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            PetsViewController(dataSource: dogsDataProvider).configure(for: .dogs),
            PetsViewController(dataSource: catsDataProvider).configure(for: .cats)
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
