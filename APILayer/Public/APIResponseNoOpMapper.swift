//
//  APIResponseNoOpMapper.swift
//  APILayer
//

public struct APIResponseNoOpMapper<T: APIResponse>: APIResponseCustomMapping {
    public static func map(response: T) throws -> T {
        response
    }
}
