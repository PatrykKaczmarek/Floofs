//
// UIColor.swift
// Floofs
//

import UIKit

extension UIColor {
    class var placeholderGray: UIColor {
        UIColor(hex: "#d9d9d9")
    }

    class var backgroundGray: UIColor {
        UIColor(hex: "#d1d3d4")
    }

    convenience init(hex: String, alpha: Double = 1) {
        let chars = Array(hex.dropFirst())
        self.init(
            red: Double(strtoul(String(chars[0...1]), nil, 16)) / 255,
            green: Double(strtoul(String(chars[2...3]), nil, 16)) / 255,
            blue: Double(strtoul(String(chars[4...5]), nil, 16)) / 255,
            alpha: alpha
        )
    }
}
