//
// DogsImagesRequest.swift
// DogsAPI
//

import APILayer

struct DogsImagesRequest: APIRequest {
    typealias ResponseMapper = DogsImagesResponseMapper

    var path: String {
        [
            "api/breed/\(breed)",
            subbreed,
            "images"
        ].compactMap({ $0 }).joined(separator: "/")
    }

    var method: APIRequestMethod {
        .get
    }

    let breed: String

    let subbreed: String?
}
