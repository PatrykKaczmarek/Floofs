//
// UIView.swift
// Floofs
//
        
import UIKit

extension UIView {
    class func autoLayoutView() -> Self {
        self.init().layoutable()
    }

    @discardableResult func layoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
