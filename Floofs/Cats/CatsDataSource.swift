//
// CatsDataSource.swift
// Floofs
//
        
protocol CatsDataSource {

    var cats: [Cat] { get }

    func fetchCats(completion: ((Bool) -> Void)?)
}

import CatsAPI

final class CatsDataProvider: CatsDataSource {

    private let apiClient: CatsAPIClient

    private(set) var cats: [Cat] = []

    init(apiKey: String) {
        apiClient = CatsAPIClient(urlSession: .shared, apiKey: apiKey)
    }

    func fetchCats(completion: ((Bool) -> Void)?) {
        apiClient.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let cats):
                self?.cats = cats
                completion?(true)
            case .failure:
                // TODO: - handle error
                completion?(false)
            }
        }
    }
}
