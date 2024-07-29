//
//  DogsAPIConfiguration.swift
//  DogsAPI
//

import APILayer

struct DogsAPIConfiguration: APIConfiguration {
    let host = "dog.ceo"
    let scheme: APIScheme = .https
    let apiKey: APIKey? = nil
}
