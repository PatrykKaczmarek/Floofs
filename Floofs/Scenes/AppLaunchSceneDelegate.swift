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
        tabBarController.tabBar.tintColor = .orange
        tabBarController.viewControllers = Tab.allCases.compactMap { tab in
            dataSource(for: tab).flatMap {
                PetsViewController(dataSource: $0)
                    .setNavigationDelegate(self)
                    .configure(for: tab)
                    .embedInNavigationController()
            }
        }
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

// MARK: - PetsViewController

private extension PetsViewController {
    func setNavigationDelegate(_ delegate: PetsViewControllerNavigationDelegate) -> Self {
        navigationDelegate = delegate
        return self
    }
}

// MARK: - PetsViewControllerNavigationDelegate

extension AppLaunchSceneDelegate: PetsViewControllerNavigationDelegate {
    func pets(viewController: PetsViewController, didSelect pet: Pet) {
        guard let tab = tab(embedding: viewController), let imagesProvider = dataSource(for: tab) else {
             return
        }
        let petGalleryViewController = PetGalleryViewController(pet: pet, imagesProvider: imagesProvider)
        viewController.navigationController?.pushViewController(petGalleryViewController, animated: true)
    }
}

// MARK: - Private

private extension AppLaunchSceneDelegate {
    func tab(embedding viewController: PetsViewController) -> Tab? {
        switch viewController.dataSource {
        case is DogsDataProvider:
            return .dogs
        case is CatsDataProvider:
            return .cats
        default:
            return nil
        }
    }

    func dataSource(for tab: Tab) -> (any PetsDataSource & PetImageDataProviding)? {
        switch tab {
        case .dogs:
            return dogsDataProvider
        case .cats:
            return catsDataProvider
        }
    }
}
