//
//  APIRequestBuilder.swift
//  APILayer
//

import Foundation

struct APIRequestBuilder {
    enum UnderlyingError: Error {
        case cannotComposeURL
    }

    static func build(request: some APIRequest, baseURL: URL, apiKey: APIKey?) throws -> URLRequest {
        var components = URLComponents()
        components.path = [request.apiVersion, request.path].compactMap { $0 }.joined(separator: "/")
        components.queryItems = request.queryItems
        guard let url = components.url(relativeTo: baseURL) else {
            throw UnderlyingError.cannotComposeURL
        }

        let authenticationHeaders = apiKey.flatMap { [$0.header: $0.value] } ?? [:]
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.defaultHeaders.merging(authenticationHeaders) { (_, new) in new }
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = try? request.encoder.encode(request)
        return urlRequest
    }
}
