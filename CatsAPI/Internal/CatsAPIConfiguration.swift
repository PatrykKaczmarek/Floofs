//
//  CatsAPIConfiguration.swift
//  CatsAPI
//

import APILayer

struct CatsAPIConfiguration: APIConfiguration {

    // MARK: - Properties

    let host = "api.thecatapi.com"
    let scheme: APIScheme = .https
    let apiKey: APIKey?

    // MARK: - Constructor

    init(apiKey: String) {
        self.apiKey = APIKey(header: "x-api-key", value: apiKey)
    }
}
