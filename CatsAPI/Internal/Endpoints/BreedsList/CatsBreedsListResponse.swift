//
//  CatsBreedsListResponse.swift
//  CatsAPI
//

import APILayer

// swiftlint:disable nesting
struct CatsBreedsListResponse: APIResponse {
    struct Content: Decodable {
        let identifier: String
        let name: String
        let origin: String
        let description: String
        let countryCode: String
        let lifeSpan: String
        let temperament: String
        let image: Image?
        let weight: Weight

        struct Image: Decodable {
            let url: String
        }

        struct Weight: Decodable {
            let imperial: String
            let metric: String
        }

        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
            case origin
            case description
            case countryCode = "country_code"
            case lifeSpan = "life_span"
            case temperament
            case image
            case weight
        }
    }

    let content: [Content]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var result: [Content] = []
        while !container.isAtEnd {
            result.append(try container.decode(Content.self))
        }
        self.content = result
    }
}
