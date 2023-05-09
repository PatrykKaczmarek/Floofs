//
//  APIResponseCustomMapping.swift
//  APILayer
//

import Foundation

public protocol APIResponseCustomMapping {
    associatedtype Model: Any
    associatedtype Response: APIResponse
    static func map(response: Response) throws -> Model
}
