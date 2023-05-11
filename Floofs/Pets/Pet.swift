//
// Pet.swift
// Floofs
//
        
protocol Pet {

    var identifier: String { get }

    var displayName: String { get }

    var imageURLs: [String] { get }

    var coverImageURL: String? { get }

    var isImageFetchCompleted: Bool { get }
}
