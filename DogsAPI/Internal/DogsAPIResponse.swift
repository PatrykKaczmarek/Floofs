//
//  DogsAPIResponse.swift
//  DogsAPI
//

import APILayer

struct DogsAPIResponse<Content: Decodable>: APIResponse {
    let message: Content
    let status: String
}
