//
// Tab.swift
// Floofs
//

import UIKit

enum Tab: CaseIterable {
    case dogs
    case cats

    var title: String {
        switch self {
        case .cats:
            return "Cats"
        case .dogs:
            return "Dogs"
        }
    }

    var image: UIImage {
        switch self {
        case .cats:
            return #imageLiteral(resourceName: "cat_deselected")
        case .dogs:
            return #imageLiteral(resourceName: "dog_deselected")

        }
    }

    var selectedImage: UIImage {
        switch self {
        case .cats:
            return #imageLiteral(resourceName: "cat_selected")
        case .dogs:
            return #imageLiteral(resourceName: "dog_selected")
        }
    }
}
