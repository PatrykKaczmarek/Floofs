//
// Pet.swift
// Floofs
//

protocol Pet {
    /// An identifier of the pet.
    var identifier: String { get }

    /// A name of the pet which should be used in UI layer.
    var displayName: String { get }

    /// An array of urls pointing to the pet's images.
    var imageURLs: [String] { get }

    /// A cover image of the pet.
    var coverImageURL: String? { get }

    /// A boolean value indicating whether all pet's image urls have been downloaded.
    /// - SeeAlso: `imageURLs`.
    var isImageFetchCompleted: Bool { get }
}
