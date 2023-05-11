//
// AppLaunchFailureSceneDelegate.swift
// Floofs
//

import UIKit

final class AppLaunchFailureSceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    private var appConfigError: AppConfigError?

    // MARK: - UIWindowSceneDelegate

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: scene)
        appConfigError = session.userInfo?.appConfigError
        let viewController = AppLaunchFailureViewController(error: appConfigError)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
