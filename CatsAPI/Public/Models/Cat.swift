//
// Cat.swift
// CatsAPI
//
        
public struct Cat {
    public let identifier: String
    public let name: String
    public let description: String
    public let lifeSpan: String
    public let temperament: String
    public let origin: Origin
    public var images: Images

    public struct Origin {
        public let country: String
        public let countryCode: String
        public var countryFlag: String {
            countryCode
                .unicodeScalars
                .map({ 127397 + $0.value })
                .compactMap(UnicodeScalar.init)
                .map(String.init)
                .joined()
        }
    }

    public struct Images {
        public let coverImageUrl: String?
        public var urls: [String] = []
        public var isComplete = false
    }

    public struct Weight {
        public let imperial: String
        public let metric: String
    }

    mutating func append(images urls: [String], isComplete: Bool) {
        self.images.urls.append(contentsOf: urls)
        self.images.isComplete = isComplete
    }
}
