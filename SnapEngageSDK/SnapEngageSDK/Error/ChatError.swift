//
//  ChatError.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 14..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation


public enum ChatError: Error {
    case noChatConfiguration
    case javaScriptCouldNotLoad
    case javaScriptError(message: String?)
    case invalidProvider(provider: String)
    case invalidWidgetId(widgetId: String)
    case invalidEntryPageUrl(url: URL)
    case invalidJsUrl(url: URL)
    case invalidInstanceUrl(url: URL)
    case httpError(url: URL, statusCode: Int?)
    case noData(url: URL)
    case apiError(statusCode: Int, message: String)
}

extension ChatError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noChatConfiguration:
            return "No configuration - You have to call the ChatView's setConfiguration method first"
        case .javaScriptCouldNotLoad:
            return "JavaScript could not loaded"
        case .javaScriptError(message: let message):
            return "JavaScript error - \(message ?? "")"
        case .invalidProvider(provider: let provider):
            return "The provider (\(provider) in the ChatConfiguration is invalid."
        case .invalidJsUrl(url: let url):
            return "Invalid jsUrl (\(url)). It has to be https url."
        case .invalidEntryPageUrl(url: let url):
            return "Invalid entryPageUrl (\(url)). It has to be https or http url."
        case .httpError(url: let url, statusCode: let statusCode):
            return "HTTPError for url: \(url.absoluteString) statusCode: \(String(describing: statusCode))"
        case .noData(url: let url):
             return "There is no data for url: \(url.absoluteString)"
        case .invalidWidgetId(widgetId: let widgetId):
            return "The widgetId (\(widgetId) in the ChatConfiguration is invalid."
        case .invalidInstanceUrl(url: let url):
            return "Invalid instanceUrl (\(url)). It has to be https or http url."
        case .apiError(statusCode: let statusCode, message: let message):
            return "ApiError: StatusCode: (\(statusCode)) message: (\(message))"
        }
    }
}
