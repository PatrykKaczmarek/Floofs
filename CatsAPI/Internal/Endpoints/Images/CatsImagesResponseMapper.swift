//
// CatsImagesResponseMapper.swift
// CatsAPI
//
        
import APILayer

struct CatsImagesResponseMapper: APIResponseCustomMapping {
    static func map(response: CatsImagesResponse) throws -> [String] {
        response.content.map { $0.url }
    }
}
