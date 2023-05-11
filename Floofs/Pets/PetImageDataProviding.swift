//
// PetImageDataProviding.swift
// Floofs
//

protocol PetImageDataProviding {

    func imagesFetchCompleted(for pet: Pet) -> Bool

    func fetchImages(pet: Pet, completion: ((Pet) -> Void)?)
}

extension PetImageDataProviding where Self: PetsDataSource {

    func fetchImages(pet: Pet, completion: ((Pet) -> Void)?) {
        guard let index = pets.firstIndex(where: { $0.identifier == pet.identifier }) else {
            completion?(pet)
            return
        }
        fetchImages(petIndex: index, completion: completion)
    }

    func imagesFetchCompleted(for pet: Pet) -> Bool {
        pets.first(where: { $0.identifier == pet.identifier })?.isImageFetchCompleted ?? true
    }
}
