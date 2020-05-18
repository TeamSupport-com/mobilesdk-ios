//
//  HtmlLoaderTests.swift
//  SnapEngageSDKTests
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import XCTest
@testable import SnapEngageSDK

class HtmlLoaderTests: XCTestCase {
    
    let htmlLoader = HtmlLoader()
    
    func testEmpty() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: ""), in: "")
        
        XCTAssertEqual(replaced, "")
    }
    
    func testprovider() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: "myprovider"), in: "[provider]")
        
        XCTAssertEqual(replaced, "myprovider")
    }
    
    func testMultipleprovider() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: "myprovider"), in: "[provider],[provider]")
        
        XCTAssertEqual(replaced, "myprovider,myprovider")
    }
    
    func testUrl() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: ""), in: "[jsUrl]")
        
        XCTAssertEqual(replaced, "http://www.google.com")
    }
    
    func testMultipleUrl() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: ""), in: "[jsUrl],[jsUrl]")
        
        XCTAssertEqual(replaced, "http://www.google.com,http://www.google.com")
    }
    
    func testUrlAndprovider() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: "myprovider"), in: "[jsUrl],[provider]")
        
        XCTAssertEqual(replaced, "http://www.google.com,myprovider")
    }
    
    func testCustomVariables() {
        let replaced = htmlLoader.replacePlaceholders(with: ChatConfiguration(jsUrl: URL(string: "http://www.google.com")!, provider: "", customVariables: [
            "name" : "John"
        ]), in: "<html>\n[customVariables]\n</html>")
        
        XCTAssertEqual(replaced, "<html>\n<script type=\"text/javascript\">\n var name = \"John\";\n</script>\n</html>")
    }
}
