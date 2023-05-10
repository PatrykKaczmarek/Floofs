//
// DogsRandomImageResponseMapper.swift
// DogsAPI
//
        
import APILayer

struct DogsRandomImageResponseMapper: APIResponseCustomMapping {
    static func map(response: DogsRandomImageResponse) throws -> String {
        response.message
    }
}
