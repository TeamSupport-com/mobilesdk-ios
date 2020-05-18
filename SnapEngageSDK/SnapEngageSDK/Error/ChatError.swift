//
//  ChatError.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation


public enum ChatError: Error {
    case noChatConfiguration
    case javaScriptCouldNotLoad
    case javaScriptError(message: String?)
    case invalidProvider(provider: String)
    case invalidEntryPageUrl(url: URL)
    case invalidJsUrl(url: URL)
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
            return "The provider (\(provider) in the ChatConfiguration is invalid. "
        case .invalidJsUrl(url: let url):
            return "Invalid jsUrl (\(url)). It has to be https url."
        case .invalidEntryPageUrl(url: let url):
            return "Invalid entryPageUrl (\(url)). It has to be https or http url."
        }
    }
}
