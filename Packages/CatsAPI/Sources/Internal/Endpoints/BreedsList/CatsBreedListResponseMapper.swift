//
//  CatsBreedListResponseMapper.swift
//  CatsAPI
//

import APILayer

struct CatsBreedListResponseMapper: APIResponseCustomMapping {
    static func map(response: CatsBreedsListResponse) throws -> [Cat] {
        response.content.map {
            Cat(
                identifier: $0.identifier,
                breed: $0.name,
                description: $0.description,
                lifeSpan: $0.lifeSpan,
                temperament: $0.temperament,
                origin: Cat.Origin(
                    country: $0.origin,
                    countryCode: $0.countryCode
                ),
                images: Cat.Images(
                    coverImageUrl: $0.image?.url
                )
            )
        }
    }
}
