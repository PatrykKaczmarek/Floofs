//
//  AppDelegate.swift
//  Floofs
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - UIApplicationDelegate

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        var userInfo: [String: Any] = [:]
        do {
            try AppConfig.read(into: &userInfo)
            return AppScene.launch.sceneConfiguration(
                session: connectingSceneSession,
                userInfo: userInfo
            )
        } catch {
            return AppScene.failureLaunch.sceneConfiguration(
                session: connectingSceneSession,
                userInfo: userInfo
            )
        }
    }
}
