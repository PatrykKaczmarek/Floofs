//
//  CatsBreedListResponseMapper.swift
//  CatsAPI
//

import APILayer

struct CatsBreedListResponseMapper: APIResponseCustomMapping {
    static func map(response: CatsBreedsListResponse) throws -> [Cat] {
        response.content.map {
            Cat(identifier: $0.id, breed: $0.name)
        }
    }
}
