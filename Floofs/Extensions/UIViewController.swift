//
// UIViewController.swift
// Floofs
//
        

import UIKit

extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
