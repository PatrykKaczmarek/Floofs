//
// Dog.swift
// DogsAPI
//
        
public struct Dog {
    public let identifier: String
    
    public let breed: String

    public let subbreed: String?

    public var imagesURLs: [String]?

    mutating func addImages(urls: [String]) {
        imagesURLs = urls
    }
}
