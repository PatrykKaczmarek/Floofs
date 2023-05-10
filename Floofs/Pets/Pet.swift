//
// Pet.swift
// Floofs
//
        
protocol Pet {
    var displayName: String { get }

    var imageURLs: [String] { get }

    var coverImageURL: String? { get }
}
