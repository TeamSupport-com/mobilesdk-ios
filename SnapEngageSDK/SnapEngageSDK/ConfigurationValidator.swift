//
//  ConfigurationValidator.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 24..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import UIKit

/// Helper class to validate ChatConfiguration
class ConfigurationValidator {

    
    /// Validates the ChatConfiguration
    /// WidgetId has to be non-empty string
    /// Provider has to be non-empty string
    /// jsUrl has to be a https string
    /// entryPageUrl has to be a https or http string
    /// baseInstanceUrl has to be a https or http string
    /// - Parameters:
    ///     - configuration: The ChatConfiguration you want to validate
    /// - Throws: invalidProvider, invalidJsUrl, invalidEntryPageUrl ChatErrors
    func validate(configuration: ChatConfiguration) throws {
        
        if configuration.widgetId.isEmpty {
            throw ChatError.invalidWidgetId(widgetId: configuration.widgetId)
        }
        
        if configuration.provider.isEmpty {
            throw ChatError.invalidProvider(provider: configuration.provider)
        }
        
        if !configuration.jsUrl.isHttpsUrl {
            throw ChatError.invalidJsUrl(url: configuration.jsUrl)
        }
        
        if !configuration.baseInstanceUrl.isNetwokUrl {
            throw ChatError.invalidInstanceUrl(url: configuration.baseInstanceUrl)
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
