//
// AppConfigError.swift
// Floofs
//
        
enum AppConfigError: Error {
    case fileNotFound
    case emptyContent
    case decodingError(Error)
    case wrongXMLFormat
    case missingEntry(String)

    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return "A \"AppConfig.plist\" file does not exist."
        case .emptyContent:
            return "A \"AppConfig.plist\" is empty."
        case .decodingError(let error):
            return "A \"AppConfig.plist\" decoding failed due to error: \(error)"
        case .wrongXMLFormat:
            return "A \"AppConfig.plist\" has wrong format."
        case .missingEntry(let key):
            return "An entry for \"\(key)\" is missing."
        }
    }

    var recoverySuggestion: String {
        let mainSuggestion: String
        switch self {
        case .fileNotFound:
            mainSuggestion = "Paste \"AppConfig.plist\" file in the correct place mentioned in README."
        case .emptyContent:
            mainSuggestion = "Use proper \"AppConfig.plist\" file which is not empty."
        case .decodingError, .wrongXMLFormat, .missingEntry:
            mainSuggestion = "Use proper \"AppConfig.plist\" given by a developer."
        }
        return """
        \(mainSuggestion)

        After resolving a problem, remove the application from a device/simulator and install it again.
        """
    }
}
