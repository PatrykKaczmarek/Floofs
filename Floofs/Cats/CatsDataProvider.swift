//
// CatsDataProvider.swift
// Floofs
//

import CatsAPI

final class CatsDataProvider: PetsDataSource, PetImageDataProviding {

    // MARK: - Properties

    private let apiClient: CatsAPIClient

    private(set) var pets: [Cat] = []

    // MARK: - Constructor

    init(apiKey: String) {
        apiClient = CatsAPIClient(urlSession: .shared, apiKey: apiKey)
    }

    // MARK - PetsDataSource

    func fetchPets(completion: ((Bool) -> Void)?) {
        apiClient.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let cats):
                self?.pets = cats.sorted(by: { $0.breed < $1.breed })
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
        apiClient.fetchImages(cat: pet) { [weak self] result in
            switch result {
            case .success(let catWithImages):
                self?.pets.replace(
                    with: catWithImages,
                    elementMatching: { $0.identifier == catWithImages.identifier }
                )
                completion?(catWithImages)
            case .failure(let error):
                print(error)
                // TODO: - handle error
                completion?(pet)
            }
        }
    }
}
