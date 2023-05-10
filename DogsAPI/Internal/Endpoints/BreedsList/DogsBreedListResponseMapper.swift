//
//  DogsBreedListResponseMapper.swift
//  DogsAPI
//

import APILayer

struct DogsBreedListResponseMapper: APIResponseCustomMapping {
    static func map(response: DogsBreedsListResponse) throws -> [Dog] {
        response.message.reduce(into: []) { (result, dictionary) in
            result.append(contentsOf: {
                if dictionary.value.isEmpty {
                    return [
                        Dog(
                            identifier: dictionary.key,
                            breed: dictionary.key,
                            subbreed: nil
                        )
                    ]
                } else {
                    return dictionary.value.map {
                        Dog(
                            identifier: "\($0)-\(dictionary.key)",
                            breed: dictionary.key,
                            subbreed: $0
                        )
                    }
                }
            }())
        }
    }
}
