//
//  BreedListResponseMapper.swift
//  DogsAPI
//

import APILayer

struct BreedListResponseMapper: APIResponseCustomMapping {
    static func map(response: BreedsListResponse) throws -> [Dog] {
        response.message.reduce(into: []) { (result, dictionary) in
            if dictionary.value.isEmpty {
                result.append(Dog(breed: dictionary.key, subbreed: nil))
            } else {
                result.append(contentsOf: dictionary.value.map { Dog(breed: dictionary.key, subbreed: $0) })
            }
        }
    }
}
