//
// Dog.swift
// Floofs
//

import DogsAPI

extension Dog: Pet {
    var displayName: String {
        [breed, subbreed].compactMap({ $0?.capitalized }).joined(separator: " ")
    }

    var imageURLs: [String] {
        images.urls
    }

    var coverImageURL: String? {
        images.coverImageUrl
    }

    var isImageFetchCompleted: Bool {
        images.isComplete
    }
}
