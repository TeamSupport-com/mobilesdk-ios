//
//  ChatConfiguration.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Class to configure the chat.
public class ChatConfiguration: NSObject {
    let jsUrl: URL
    let provider: String
    let entryPageUrl: URL
    let customVariables: [String: Any]?

    
    /// ChatConfiguration init
    ///
    /// - Parameters:
    ///     - jsUrl: is the url where the chat javascript can be found. Has to be a valid URL.
    ///     - provider: is the provider of the chat.
    ///     - entryPageUrl: is the url what is going to be shown in the frontend side. Has to be a valid URL.
    ///     - customVariables: is the custom variables that can be passed to the javascript.
    @objc public init(jsUrl: URL, provider: String, entryPageUrl: URL, customVariables: [String: Any]? = nil) {
        self.jsUrl = jsUrl
        self.provider = provider
        self.entryPageUrl = entryPageUrl
        self.customVariables = customVariables
    }
}
