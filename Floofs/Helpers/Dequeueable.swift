//
// Dequeueable.swift
// Floofs
//

import UIKit

protocol Dequeueable {
    static var reuseIdentifier: String { get }
}

extension Dequeueable {
    static var reuseIdentifier: String {
        String(describing: type(of: self))
    }
}

extension UICollectionViewCell: Dequeueable {}
