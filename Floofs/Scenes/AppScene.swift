//
// AppScene.swift
// Floofs
//

import UIKit
        
enum AppScene {
    case launch
    case failureLaunch

    var configurationName: String {
        switch self {
        case .launch:
            return "App Launch Configuration"
        case .failureLaunch:
            return "App Launch Failure Configuration"
        }
    }

    func sceneConfiguration(session: UISceneSession, userInfo: [String: Any]) -> UISceneConfiguration {
        let scene = UISceneConfiguration(name: self.configurationName, sessionRole: session.role)
        session.userInfo = userInfo
        return scene
    }
}
