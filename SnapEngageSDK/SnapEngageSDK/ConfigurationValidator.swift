//
//  ConfigurationValidator.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import UIKit

/// Helper class to validate ChatConfiguration
class ConfigurationValidator {

    
    /// Validates the ChatConfiguration
    /// Provider has to be non-empty string
    /// jsUrl has to be a https string
    /// entryPageUrl has to be a https or http string
    /// - Parameters:
    ///     - configuration: The ChatConfiguration you want to validate
    /// - Throws: invalidProvider, invalidJsUrl, invalidEntryPageUrl ChatErrors
    func validate(configuration: ChatConfiguration) throws {
        if configuration.provider.isEmpty {
            throw ChatError.invalidProvider(provider: configuration.provider)
        }
        
        if !configuration.jsUrl.isHttpsUrl {
            throw ChatError.invalidJsUrl(url: configuration.jsUrl)
        }
        
        if !configuration.entryPageUrl.isNetwokUrl {
            throw ChatError.invalidEntryPageUrl(url: configuration.entryPageUrl)
        }
    }
}

private extension URL {
    
    var isHttpsUrl: Bool {
        self.scheme == "https"
    }
    
    var isHttpUrl: Bool {
        self.scheme == "http"
    }
    
    var isNetwokUrl: Bool {
        !self.absoluteString.isEmpty && (isHttpsUrl || isHttpUrl)
    }
}
