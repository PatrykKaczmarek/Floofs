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
}
