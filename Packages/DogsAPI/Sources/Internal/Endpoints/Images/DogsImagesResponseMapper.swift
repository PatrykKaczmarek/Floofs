//
// DogsImagesResponseMapper.swift
// DogsAPI
//

import APILayer

struct DogsImagesResponseMapper: APIResponseCustomMapping {
    static func map(response: DogsImagesResponse) throws -> [String] {
        response.message
    }
}
