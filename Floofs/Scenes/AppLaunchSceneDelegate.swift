//
//  AppLaunchSceneDelegate.swift
//  Floofs
//

import UIKit

final class AppLaunchSceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        let apiKey = session.userInfo?.catsAPIKey
        let catsDataSource = CatsDataProvider(apiKey: apiKey!)
        window = UIWindow(windowScene: scene)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            DogsViewController().configure(for: .dogs),
            CatsViewController(dataSource: catsDataSource).configure(for: .cats)
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
