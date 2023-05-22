//
// PetsDataSource.swift
// Floofs
//

protocol PetsDataSource {
    associatedtype PetType: Pet

    /// An array of opaque pet types.
    /// Classes conforming this protocols will have a concrete type specified by associated type.
    var pets: [PetType] { get }

    /// Fetches all pets of associated type.
    /// - Parameter completion: A completion containing a boolean value as an argument.
    ///                         If succeeded, returns `true`. Otherwise `false`. Invoked on a main thread.
    func fetchPets(completion: ((Bool) -> Void)?)

    /// Fetches pet's images.
    /// - Warning: Might be called several times, depending on whether pets' images
    ///            are being provided in the chunks (i.e. paginated) or not.
    /// - Parameters:
    ///   - petIndex: The index of a pet from `pets` array.
    ///   - completion: A completion containing an optional pet object as an argument.
    ///                 If  images fetch succeeds, then an updated object is returned.
    ///                 If  images fetch fails, then an original object is returned.
    ///                 If  `petIndex` cannot be find, the returns nil.
    ///                 Invoked on a main thread.
    func fetchImages(petIndex: Int, completion: ((Pet?) -> Void)?)
}
