//
// UIView.swift
// Floofs
//

import  UIKit

extension UIView {
    /// Constructs the receiver with regular `init` function and adapts it to the Auto Layout engine
    /// by setting `translatesAutoresizingMaskIntoConstraints` to false.
    class func autoLayoutView() -> Self {
        self.init().layoutable()
    }

    /// Sets the receiver's `translatesAutoresizingMaskIntoConstraints` to false.
    /// - Returns: An instance of the receiver.
    @discardableResult func layoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Adds in the loop given list of views as subviews of the receiver.
    /// - Parameter subviews: List of views to be added as the receiver's subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
