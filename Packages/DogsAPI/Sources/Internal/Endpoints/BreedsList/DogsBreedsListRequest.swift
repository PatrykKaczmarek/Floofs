//
//  DogsBreedsListRequest.swift
//  DogsAPI
//

import APILayer

struct DogsBreedsListRequest: APIRequest {
    typealias ResponseMapper = DogsBreedListResponseMapper

    var path: String {
        "api/breeds/list/all"
    }

    var method: APIRequestMethod {
        .get
    }
}
