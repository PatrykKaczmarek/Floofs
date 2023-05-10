//
// Array.swift
// Floofs
//

extension Array {
    @discardableResult
    mutating func replace(with element: Element, elementMatching: (Element) -> Bool) -> Bool {
        if let index = firstIndex(where: elementMatching) {
            self[index] = element
            return true
        }
        return false
    }
}
