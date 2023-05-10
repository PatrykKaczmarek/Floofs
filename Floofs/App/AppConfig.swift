//
// AppConfig.swift
// Floofs
//

import Foundation

struct AppConfig {

    fileprivate enum Keys: String {
        case catsAPIKey = "CatsAPIKey"
        case appConfigError = "AppConfigError"
    }

    static func read(into result: inout [String: Any]) throws {
        guard let plistPath = Bundle.main.path(forResource: "AppConfig", ofType: "plist") else {
            throw saveBeforeThrowing(error: AppConfigError.fileNotFound, result: &result)
        }
        guard let data = FileManager.default.contents(atPath: plistPath) else {
            throw saveBeforeThrowing(error: AppConfigError.emptyContent, result: &result)
        }
        do {
            let config = try data.decodeToPlist()
            guard config[Keys.catsAPIKey.rawValue] is String else {
                throw saveBeforeThrowing(
                    error: AppConfigError.missingEntry(Keys.catsAPIKey.rawValue),
                    result: &result
                )
            }
            result.merge(config) { (_, new) in new }
        } catch {
            throw saveBeforeThrowing(error: error, result: &result)
        }
    }
}

extension Dictionary where Key == String, Value == Any {
    var appConfigError: AppConfigError? {
        self[AppConfig.Keys.appConfigError.rawValue] as? AppConfigError
    }

    var catsAPIKey: String? {
        self[AppConfig.Keys.catsAPIKey.rawValue] as? String
    }
}

private extension AppConfig {
    static func saveBeforeThrowing(error: Error, result: inout [String: Any]) -> Error {
        result[AppConfig.Keys.appConfigError.rawValue] = error
        return error
    }
}

private extension Data {
    func decodeToPlist() throws -> [String: AnyObject] {
        do {
            var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
            let result = try PropertyListSerialization.propertyList(
                from: self,
                options: .mutableContainersAndLeaves,
                format: &propertyListFormat
            )
            guard let plist = result as? [String: AnyObject] else {
                throw AppConfigError.wrongXMLFormat
            }
            return plist
        } catch {
            throw AppConfigError.decodingError(error)
        }
    }
}
