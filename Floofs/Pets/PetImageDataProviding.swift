//
// PetImageDataProviding.swift
// Floofs
//

protocol PetImageDataProviding {
    /// Indicates whether images urls for given pets have been already downloaded and stored in the `Pet` object.
    /// - Parameter pet: A pet object for which the check should be made against.
    /// - Returns: `true` if all images are fetched. Otherwise `false`.
    func imagesFetchCompleted(for pet: Pet) -> Bool

    /// Fetches pet's images.
    /// - Warning: Might be called several times, depending on whether pets' images
    ///            are being provided in the chunks (i.e. paginated) or not.
    /// - Parameters:
    ///   - pet: A pet which images should be fetched.
    ///   - completion: A completion containing an optional pet object as an argument.
    ///                 If  images fetch succeeds, then an updated object is returned.
    ///                 If  images fetch fails, then an original object is returned.
    ///                 Invoked on a main thread.
    func fetchImages(pet: Pet, completion: ((Pet) -> Void)?)
}

extension PetImageDataProviding where Self: PetsDataSource {
    func fetchImages(pet: Pet, completion: ((Pet) -> Void)?) {
        guard let index = pets.firstIndex(where: { $0.identifier == pet.identifier }) else {
            completion?(pet)
            return
        }
        fetchImages(petIndex: index) { petWithImages in
            switch petWithImages {
            case .some(let pet):
                completion?(pet)
            case .none:
                completion?(pet)
            }
        }
    }

    func imagesFetchCompleted(for pet: Pet) -> Bool {
        pets.first(where: { $0.identifier == pet.identifier })?.isImageFetchCompleted ?? true
    }
}
