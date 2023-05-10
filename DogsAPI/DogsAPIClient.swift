//
//  DogsAPIClient.swift
//  DogsAPI
//

import APILayer

public final class DogsAPIClient: APIClient {
    public init(urlSession: URLSession) {
        super.init(configuration: DogsAPIConfiguration(), session: urlSession)
    }

    public func fetchAllBreeds(completion: @escaping (Result<[Dog], APIClientError>) -> Void) {
        perform(request: BreedsListRequest(), completion: completion)
    }
}
