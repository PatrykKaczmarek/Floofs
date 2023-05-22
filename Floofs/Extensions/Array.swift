//
// Array.swift
// Floofs
//

extension Array {
    /// Iterates through the receiver and replaces an element find by `elementMatching` closure with an `element`
    /// given as a first argument of this function.
    /// - Warning: Replaces only first matching element.
    /// - Parameters:
    ///   - element: A new element that will be used for replacement.
    ///   - elementMatching: A closure indicating whether given, as a closure's argument, `element` object
    ///                      should be replaced by `element` given as the function parameter.
    /// - Returns: A boolean value indicating whether a replacement was successful.
    @discardableResult mutating func replace(
        with element: Element,
        elementMatching: (Element) -> Bool
    ) -> Bool {
        if let index = firstIndex(where: elementMatching) {
            self[index] = element
            return true
        }
        return false
    }
}
