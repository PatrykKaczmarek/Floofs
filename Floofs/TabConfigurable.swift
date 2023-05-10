//
// TabConfigurable.swift
// Floofs
//
        

import UIKit

protocol TabConfigurable where Self: UIViewController {
    func configure(for tab: Tab) -> UIViewController
}

extension UIViewController: TabConfigurable {
    func configure(for tab: Tab) -> UIViewController {
        tabBarItem.title = tab.title
        tabBarItem.image = tab.image
        tabBarItem.selectedImage = tab.selectedImage
        return self
    }
}
