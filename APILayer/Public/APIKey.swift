//
//  APIKey.swift
//  APILayer
//

public struct APIKey {
    let header: String
    let value: String

    public init(header: String, value: String) {
        self.header = header
        self.value = value
    }
}
