//
// Dog.swift
// Floofs
//


import DogsAPI

extension Dog: Pet {
    var imageURLs: [String] {
        imagesURLs ?? []
    }

    var displayName: String {
        [breed, subbreed].compactMap({ $0 }).joined(separator: " ")
    }
}
