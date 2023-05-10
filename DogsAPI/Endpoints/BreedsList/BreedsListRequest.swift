//
//  BreedsListRequest.swift
//  DogsAPI
//

import APILayer

struct BreedsListRequest: APIRequest {
    typealias ResponseMapper = BreedListResponseMapper

    var path: String {
        "api/breeds/list/all"
    }

    var method: APIRequestMethod {
        .get
    }
}
