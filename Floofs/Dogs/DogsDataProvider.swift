//
// DogsDataProvider.swift
// Floofs
//
        
import DogsAPI

final class DogsDataProvider: PetsDataSource, PetImageDataProviding {

    // MARK: - Properties

    private let apiClient: DogsAPIClient

    private(set) var pets: [Dog] = []

    // MARK: - Constructor

    init() {
        apiClient = DogsAPIClient(urlSession: .shared)
    }

    // MARK - PetsDataSource

    func fetchPets(completion: ((Bool) -> Void)?) {
        apiClient.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let dogs):
                self?.pets = dogs.sorted(by: { $0.breed < $1.breed })
                completion?(true)
            case .failure(let error):
                print(error)
                // TODO: - handle error
                completion?(false)
            }
        }
    }

    func fetchImages(petIndex: Int, completion: ((Pet) -> Void)?) {
        let pet = pets[petIndex]
        apiClient.fetchImages(dog: pet) { [weak self] result in
            switch result {
            case .success(let dogWithImages):
                self?.pets.replace(
                    with: dogWithImages,
                    elementMatching: { $0.identifier == dogWithImages.identifier }
                )
                completion?(dogWithImages)
            case .failure(let error):
                print(error)
                // TODO: - handle error
                completion?(pet)
            }
        }
    }
}
