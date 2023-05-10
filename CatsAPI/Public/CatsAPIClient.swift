//
//  CatsAPIClient.swift
//  CatsAPI
//

import APILayer

public final class CatsAPIClient {

    // MARK: - Properties

    private let apiClient: APIClient

    // MARK: - Constructor

    public init(urlSession: URLSession, apiKey: String) {
        apiClient = APIClient(configuration: CatsAPIConfiguration(apiKey: apiKey), session: urlSession)
    }

    // MARK: - API

    public func fetchAllBreeds(completion: @escaping (Result<[Cat], APIClientError>) -> Void) {
        apiClient.perform(request: CatsBreedsListRequest(), completion: completion)
    }

    public func fetchImages(cat: Cat, completion: @escaping (Result<Cat, APIClientError>) -> Void) {
        guard !cat.images.isComplete else {
            completion(.success(cat))
            return
        }
        let limit = 20
        let page = calculatePage(limit: limit, currentCount: cat.images.urls.count)
        let request = CatsImagesRequest(limit: limit, page: page, breedIdentifier: cat.identifier)
        apiClient.perform(request: request) { result in
            switch result {
            case .success(let urls):
                var newCat = cat
                newCat.append(images: urls, isComplete: urls.count < limit)
                completion(.success(newCat))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private

private extension CatsAPIClient {
    func calculatePage(limit: Int, currentCount: Int) -> Int {
        var count = currentCount
        var page = 1

        while count >= limit && count % limit == 0 {
            page += 1
            count -= limit
        }
        return page
    }
}
