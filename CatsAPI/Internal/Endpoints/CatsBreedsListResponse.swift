//
//  CatsBreedsListResponse.swift
//  CatsAPI
//

import APILayer

struct CatsBreedsListResponse: APIResponse {
    struct Content: Decodable {
        let id: String
        let name: String
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
