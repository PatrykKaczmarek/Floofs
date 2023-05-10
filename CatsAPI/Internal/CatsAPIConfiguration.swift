//
//  CatsAPIConfiguration.swift
//  CatsAPI
//

import APILayer

struct CatsAPIConfiguration: APIConfiguration {
    let host = "api.thecatapi.com"
    let scheme: APIScheme = .https
    let apiKey: APIKey?

    init(apiKey: String) {
        self.apiKey = APIKey(header: "x-api-key", value: apiKey)
    }
}
