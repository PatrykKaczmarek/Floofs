//
//  APIRequest.swift
//  APILayer
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype ResponseMapper: APIResponseCustomMapping

    var path: String { get }

    var queryItems: [URLQueryItem]? { get }

    var method: APIRequestMethod { get }

    var encoder: JSONEncoder { get }

    var apiVersion: APIVersion? { get }

    var defaultHeaders: [String: String] { get }
}

public extension APIRequest {
    var encoder: JSONEncoder {
        JSONEncoder()
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var defaultHeaders: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var apiVersion: APIVersion? {
        nil
    }

    func encode(to encoder: Encoder) throws {}
}
