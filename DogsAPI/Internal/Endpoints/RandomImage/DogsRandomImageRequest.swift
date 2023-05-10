//
// DogsRandomImageRequest.swift
// DogsAPI
//
        
import APILayer

struct DogsRandomImageRequest: APIRequest {
    typealias ResponseMapper = DogsRandomImageResponseMapper

    var path: String {
        [
            "api/breed/\(breed)",
            subbreed,
            "images/random"
        ].compactMap({ $0 }).joined(separator: "/")
    }

    var method: APIRequestMethod {
        .get
    }

    let breed: String

    let subbreed: String?
}
