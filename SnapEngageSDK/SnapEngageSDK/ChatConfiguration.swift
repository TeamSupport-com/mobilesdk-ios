//
//  ChatConfiguration.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 06..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Class to configure the chat.
public class ChatConfiguration: NSObject {
    let widgetId: String
    let baseJsUrl: URL
    let provider: String
    let entryPageUrl: URL
    let baseInstanceUrl: URL
    let customVariables: [String: Any]?
    
    internal var jsUrl: URL {
        return baseJsUrl.appendingPathComponent(widgetId).appendingPathExtension("js")
    }
    
    /// ChatConfiguration init
    ///
    /// - Parameters:
    ///     - widgetId: is the identifier of your widget.
    ///     - baseJsUrl: is the base url where the chat javascript can be found without the widgetId . Has to be a valid URL.
    ///     - provider: is the provider of the chat.
    ///     - baseInstanceUrl: is the base url without the widgetId, which can be used to call HTTP APIs
    ///     - entryPageUrl: is the url what is going to be shown in the frontend side. Has to be a valid URL.
    ///     - customVariables: is the custom variables that can be passed to the javascript.
    @objc public init(widgetId: String, baseJsUrl: URL, provider: String, entryPageUrl: URL, baseInstanceUrl: URL, customVariables: [String: Any]? = nil) {
        self.widgetId = widgetId
        self.baseJsUrl = baseJsUrl
        self.provider = provider
        self.entryPageUrl = entryPageUrl
        self.baseInstanceUrl = baseInstanceUrl
        self.customVariables = customVariables
    }
}
