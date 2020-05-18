//
//  HtmlLoader.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 06..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Helper class to load the html template from file, replaces the placeholders based on the ChatConfiguration
internal class HtmlLoader {
    
    /// It loads the html template from file, replaces the placeholders based on the ChatConfiguration
    /// - Parameters:
    ///     - configuration: ChatConfiguration that specifies the chat
    internal func loadHtml(with configuration: ChatConfiguration) -> String? {
        guard
            let path = Bundle(for: Self.self).path(forResource: "index", ofType: "html"),
            var html = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        else {
            return nil
        }
        
        html = self.replacePlaceholders(with: configuration, in: html)
        
        return html
    }
    
    
    /// It replaces the placeholders based on the ChatConfiguration
    /// - Parameters:
    ///     - configuration: ChatConfiguration that specifies the chat
    ///     - html: the html template loaded from file
    internal func replacePlaceholders(with configuration: ChatConfiguration, in html: String) -> String {
        var html = html
        
        html = html.replacingOccurrences(of: "[provider]", with: configuration.provider)
        html = html.replacingOccurrences(of: "[jsUrl]", with: configuration.jsUrl.absoluteString)
        
        let customVariablesBlock = assembleJavascriptVariablesBlock(customVariables: configuration.customVariables) ?? ""
        html = html.replacingOccurrences(of: "[customVariables]", with: customVariablesBlock)
        
        return html
    }
    
    /// It creates a javaScript string based on the given custom variables dictionary
    /// - Parameters:
    ///     - customVariables: Dictionary that represents the custom global javaScript variables given in the ChatConfiguration
    internal func assembleJavascriptVariablesBlock(customVariables: [String: Any]?) -> String? {
        guard let customVariables = customVariables else {
            return nil
        }
        
        var string = "<script type=\"text/javascript\">\n"
        
        customVariables
            .sorted(by: {$0.key < $1.key }) // sorted, because Dictionary doesn't keep the order, and we need it in unit tests
            .forEach { (key, value) in
            string.append(" var \(key) = \(quotationMark(any: value))\(value)\(quotationMark(any: value));\n")
        }
        
        string.append("</script>")
        
        return string
    }
    
    
    /// Returns a quotation mark if needed based on the given class.
    private func quotationMark(any: Any) -> String {
        switch any {
        case _ as IntegerLiteralType:
            return ""
        case _ as FloatLiteralType:
            return ""
        case _ as Bool:
            return ""
        default:
            return "\""
        }
    }
}
