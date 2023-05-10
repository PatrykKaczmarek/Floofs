//
// PetsDataSource.swift
// Floofs
//
        
protocol PetsDataSource {
    associatedtype T: Pet

    var pets: [T] { get }

    func fetchPets(completion: ((Bool) -> Void)?)

    func fetchImages(petIndex: Int, completion: ((Bool) -> Void)?)
}
