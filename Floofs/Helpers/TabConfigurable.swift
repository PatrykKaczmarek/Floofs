//
// TabConfigurable.swift
// Floofs
//

import UIKit

protocol TabConfigurable where Self: UIViewController {
    func configure(for tab: Tab) -> Self
}

extension UIViewController: TabConfigurable {
    func configure(for tab: Tab) -> Self {
        tabBarItem.title = tab.title
        tabBarItem.image = tab.image
        tabBarItem.selectedImage = tab.selectedImage
        return self
    }
}
