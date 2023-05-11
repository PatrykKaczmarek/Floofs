//
// PetsDataSource.swift
// Floofs
//

protocol PetsDataSource {
    associatedtype PetType: Pet

    var pets: [PetType] { get }

    func fetchPets(completion: ((Bool) -> Void)?)

    func fetchImages(petIndex: Int, completion: ((Pet) -> Void)?)
}
