//
// AppAppearance.swift
// Floofs
//
        

import UIKit

enum AppAppearance {
    static func setup() {
        UIBarButtonItem.appearance().tintColor = .orange

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
}
