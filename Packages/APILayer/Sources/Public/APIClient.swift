//
//  APIClient.swift
//  APILayer
//

import Foundation

open class APIClient {

    private let session: URLSession

    private let configuration: APIConfiguration

    private let acceptableStatusCodes = 200...299

    public init(configuration: APIConfiguration, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }

    public func perform<Request: APIRequest>(
        request: Request,
        completion: @escaping (Result<Request.ResponseMapper.Model, APIClientError>) -> Void?
    ) {
        let resolveSuccess: (Request.ResponseMapper.Model) -> Void = { response in
            let result: Result<Request.ResponseMapper.Model, APIClientError> = .success(response)
            DispatchQueue.main.async { completion(result) }
        }

        let resolveFailure: (APIClientError) -> Void = { error in
            let result: Result<Request.ResponseMapper.Model, APIClientError> = .failure(error)
            DispatchQueue.main.async { completion(result) }
        }

        do {
            let urlRequest = try encode(request: request)
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let self = self else {
                    return
                }
                do {
                    let data = try self.validate(data: data, response: response, error: error)
                    let result = try self.decodeResponse(from: request, using: data)
                    resolveSuccess(result)
                } catch {
                    resolveFailure(APIClientError(error: error))
                }
            }.resume()
        } catch {
            resolveFailure(.requestBuildError(error))
        }
    }

    public func perform<Request: APIRequest>(
        request: Request
    ) async throws -> Request.ResponseMapper.Model {
        do {
            let urlRequest = try encode(request: request)
            try Task.checkCancellation()
            let (data, response) = try await session.data(for: urlRequest)
            let validatedData = try validate(data: data, response: response, error: nil)
            let result = try self.decodeResponse(from: request, using: validatedData)
            return result
        } catch is CancellationError {
            throw APIClientError.cancellationError
        } catch {
            throw APIClientError(error: error)
        }
    }
}

private extension APIClient {
    func encode<Request: APIRequest>(
        request: Request
    ) throws -> URLRequest {
        do {
            let baseURL = configuration.baseURL
            return try APIRequestBuilder.build(request: request, baseURL: baseURL, apiKey: configuration.apiKey)
        } catch {
            throw APIClientError.requestBuildError(error)
        }
    }

    func decodeResponse<Request: APIRequest>(
        from request: Request,
        using data: Data
    ) throws -> Request.ResponseMapper.Model {
        do {
            let decoder = Request.ResponseMapper.Response.decoder
            let parsedResponse = try decoder.decode(Request.ResponseMapper.Response.self, from: data)
            let mappedResponse = try Request.ResponseMapper.map(response: parsedResponse)
            return mappedResponse
        } catch let error as DecodingError {
            throw APIClientError.responseDecodingError(error)
        } catch {
            throw APIClientError.responseParseError(error)
        }
    }

    // swiftlint:disable orphaned_doc_comment
    func validate(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        /// If there was an error, resolve failure immediately.
        if let error = error {
            throw APIClientError.connectionError(error)
        }
        /// If the response is invalid, resolve failure immediately.
        guard let response = response as? HTTPURLResponse else {
            throw APIClientError.responseTypeError
        }
        /// Validate against acceptable status codes.
        guard acceptableStatusCodes.contains(response.statusCode) else {
            throw APIClientError.statusCodeError(response.statusCode)
        }
        /// If data is missing, resolve failure immediately.
        /// Missing data is not the same as zero-width data – the former is considered erroreus.
        guard let data = data else {
            throw APIClientError.responseDataError
        }
        return data
    }
    // swiftlint:enable orphaned_doc_comment
}

private extension APIConfiguration {
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        return components.url!
    }
}
