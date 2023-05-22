//
// CatsImagesRequest.swift
// CatsAPI
//

import  APILayer

struct CatsImagesRequest: APIRequest {
    typealias ResponseMapper = CatsImagesResponseMapper

    var path: String {
        "images/search"
    }

    var method: APIRequestMethod {
        .get
    }

    var apiVersion: APIVersion? {
        .version1
    }

    let limit: Int

    let page: Int

    let breedIdentifier: String

    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "breed_ids", value: breedIdentifier)
        ]
    }
}
