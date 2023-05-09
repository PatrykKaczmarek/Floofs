//
//  APIResponse.swift
//  APILayer
//

import Foundation

public protocol APIResponse: Decodable {
    static var decoder: JSONDecoder { get }
}

public extension APIResponse {
    static var decoder: JSONDecoder {
        JSONDecoder()
    }
}
