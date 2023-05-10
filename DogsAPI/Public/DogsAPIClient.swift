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
        apiClient.perform(request: BreedsListRequest(), completion: completion)
    }
}
