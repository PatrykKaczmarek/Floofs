//
// UIColor.swift
// Floofs
//

import UIKit

extension UIColor {
    /// App wide, gray color for placeholders.
    class var placeholderGray: UIColor {
        UIColor(hex: "#d9d9d9")
    }

    /// App wide, gray color for backgrounds.
    class var backgroundGray: UIColor {
        UIColor(hex: "#d1d3d4")
    }

    /// Creates a color from hex value.
    /// - Parameters:
    ///   - hex: The hex value. Format: "#000000".
    ///   - alpha: The opacity component of the color object, specified as a value between 0.0 and 1.0.
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
