//
// APIVersion.swift
// APILayer
//

public enum APIVersion {
    case version1
    case custom(String)

    var rawValue: String {
        switch self {
        case .version1:
            return "v1"
        case .custom(let string):
            return string
        }
    }
}
