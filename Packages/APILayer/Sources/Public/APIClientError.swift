//
//  APIClientError.swift
//  APILayer
//

import Foundation

public enum APIClientError: Error {
    case requestBuildError(Error)
    case connectionError(Error)
    case responseTypeError
    case responseDataError
    case responseParseError(Error)
    case responseDecodingError(Error)
    case statusCodeError(Int)
    case cancellationError
    case unknown(Error)

    init(error: Error) {
        if let apiError = error as? APIClientError {
            self = apiError
        } else {
            self = .unknown(error)
        }
    }
}
