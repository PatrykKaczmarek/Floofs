//
//  APIConfiguration.swift
//  APILayer
//

public protocol APIConfiguration {
    var host: String { get }
    var scheme: APIScheme { get }
    var apiKey: APIKey? { get }
}
