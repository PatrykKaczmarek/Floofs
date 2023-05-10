//
//  DogsAPIClient.swift
//  DogsAPI
//

import APILayer

public final class DogsAPIClient {

    // MARK: - Properties

    private let apiClient: APIClient

    // MARK: - Constructor

    public init(urlSession: URLSession) {
        apiClient = APIClient(configuration: DogsAPIConfiguration(), session: urlSession)
    }

    // MARK: - API

    public func fetchAllBreeds(completion: @escaping (Result<[Dog], APIClientError>) -> Void) {
        apiClient.perform(request: DogsBreedsListRequest(), completion: completion)
    }

    public func fetchImages(dog: Dog, completion: @escaping (Result<Dog, APIClientError>) -> Void) {
        guard !dog.imagesFetched else {
            completion(.success(dog))
            return
        }
        let request = DogsImagesRequest(breed: dog.breed, subbreed: dog.subbreed)
        apiClient.perform(request: request) { result in
            switch result {
            case .success(let urls):
                var newDog = dog
                newDog.addImages(urls: urls)
                completion(.success(newDog))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: Dog

private extension Dog {
    var imagesFetched: Bool {
        imagesURLs != nil
    }
}
