//
//  CatsBreedsListRequest.swift
//  CatsAPI
//

import APILayer

struct CatsBreedsListRequest: APIRequest {
    typealias ResponseMapper = CatsBreedListResponseMapper

    var path: String {
        "breeds"
    }

    var method: APIRequestMethod {
        .get
    }

    var apiVersion: APIVersion? {
        .version1
    }
}
