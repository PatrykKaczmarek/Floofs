//
// Cat.swift
// Floofs
//
        
import CatsAPI

extension Cat: Pet {
    var displayName: String {
        name
    }

    var imageURLs: [String] {
        images.urls
    }
}

