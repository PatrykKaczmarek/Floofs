//
// UIViewController.swift
// Floofs
//

import UIKit

extension UIViewController {
    /// Embeds the receiver in the navigation stack.
    /// - Returns: An instance of `UINavigationController`.
    func embedInNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
