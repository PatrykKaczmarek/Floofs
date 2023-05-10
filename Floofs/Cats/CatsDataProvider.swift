//
// CatsDataProvider.swift
// Floofs
//

import CatsAPI

final class CatsDataProvider {

    // MARK: - Properties

    private let apiClient: CatsAPIClient

    private(set) var cats: [Cat] = []

    // MARK: - Constructor

    init(apiKey: String) {
        apiClient = CatsAPIClient(urlSession: .shared, apiKey: apiKey)
    }
}

// MARK: - CatsDataSource

extension CatsDataProvider: CatsDataSource {

    func fetchCats(completion: ((Bool) -> Void)?) {
        apiClient.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let cats):
                self?.cats = cats
                completion?(true)
            case .failure(let error):
                print(error)
                // TODO: - handle error
                completion?(false)
            }
        }
    }

    func fetchImages(cat: Cat, completion: ((Bool) -> Void)?) {
        apiClient.fetchImages(cat: cat) { [weak self] result in
            switch result {
            case .success(let catWithImages):
                self?.cats.replace(
                    with: catWithImages,
                    elementMatching: { $0.identifier == catWithImages.identifier }
                )
                completion?(true)
            case .failure(let error):
                print(error)
                // TODO: - handle error
                completion?(false)
            }
        }
    }
}

// MARK: - Private

private extension Array {
    @discardableResult
    mutating func replace(with element: Element, elementMatching: (Element) -> Bool) -> Bool {
        if let index = self.firstIndex(where: elementMatching) {
            self[index] = element
            return true
        }
        return false
    }
}
