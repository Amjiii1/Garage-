//
//  AppInfoHelper.swift
//  Garage
//
//  Created by Amjad on 07/02/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import Foundation

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

/// This class is responsible for getting current and latest app version and opening AppStore for update
class AppInfoHelper {
    
    private static var trackViewID = ""
    
    /// Returns current version of App
    ///
    /// - Returns: String
    static func getAppCurrentVersion()-> String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return version
        }
        return ""
    }
    
    /// Checks for update
    static func isUpdateAvailable() throws -> (Bool, String) {
        
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)")
            else {
                throw VersionError.invalidBundleInfo
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw VersionError.invalidResponse
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            if let trackViewUrl = result["trackViewUrl"] as? String, let trackViewUrlId = trackViewUrl.between("app/", "?") {
                self.trackViewID = trackViewUrlId
            }
            print("version in app store", version, currentVersion);
            return (version != currentVersion, version)
        }
        throw VersionError.invalidResponse
    }
    
    /// Opens AppStore to update app
    ///
    /// - Returns: Void
    static func openAppStoreToUpdateApp() {
        /// Change URL when app is uploaded on AppStore
        if let url = URL(string: "itms-apps://itunes.apple.com/app/\(trackViewID)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
