//
// Cat.swift
// Floofs
//

import  CatsAPI

extension Cat: Pet {
    var displayName: String {
        breed
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
