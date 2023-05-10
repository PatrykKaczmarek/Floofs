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
        apiClient.perform(request: DogsBreedsListRequest()) { [weak self] result in
            switch result {
            case .success(let dogs):
                self?.fetchCoverImages(for: dogs, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func fetchImages(dog: Dog, completion: @escaping (Result<Dog, APIClientError>) -> Void) {
        guard !dog.images.isComplete else {
            completion(.success(dog))
            return
        }
        let request = DogsImagesRequest(breed: dog.breed, subbreed: dog.subbreed)
        apiClient.perform(request: request) { result in
            switch result {
            case .success(let urls):
                var newDog = dog
                newDog.addImages(urls: urls, isComplete: true)
                completion(.success(newDog))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


// MARK: - Private

private extension DogsAPIClient {
    func fetchCoverImages(
        for dogs: [Dog],
        completion: @escaping (Result<[Dog], APIClientError>) -> Void
    ) {
        let group = DispatchGroup()
        var dogsWithCoverImages: [Dog] = []

        dogs.forEach { dog in
            group.enter()

            let request = DogsRandomImageRequest(breed: dog.breed, subbreed: dog.subbreed)
            apiClient.perform(request: request) { result in
                switch result {
                case .success(let url):
                    var newDog = dog
                    newDog.addCoverImage(url: url)
                    dogsWithCoverImages.append(newDog)
                case .failure:
                    dogsWithCoverImages.append(dog)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(.success(dogsWithCoverImages))
        }
    }
}
