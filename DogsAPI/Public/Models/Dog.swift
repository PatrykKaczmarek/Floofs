//
// Dog.swift
// DogsAPI
//
        
public struct Dog {
    public let identifier: String
    
    public let breed: String

    public let subbreed: String?

    public var images = Images()

    public struct Images {
        public var coverImageUrl: String?
        public var urls: [String] = []
        public var isComplete = false
    }

    mutating func addImages(urls: [String], isComplete: Bool) {
        images.urls = urls
        images.isComplete = isComplete
    }

    mutating func addCoverImage(url: String) {
        images.coverImageUrl = url
    }
}
