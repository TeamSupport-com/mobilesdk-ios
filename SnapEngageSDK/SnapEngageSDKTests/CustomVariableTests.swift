//
//  CustomVariableTests.swift
//  SnapEngageSDKTests
//
//  Created by SnapEngage on 2020. 04. 06..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import XCTest
@testable import SnapEngageSDK

class CustomVariableTests: XCTestCase {

    let htmlLoader = HtmlLoader()
    
    func testNil() {
        let string = htmlLoader.assembleJavascriptVariablesBlock(customVariables: nil)
        XCTAssertNil(string)
    }
    
    func testEmpty() {
        let string = htmlLoader.assembleJavascriptVariablesBlock(customVariables: [:])
        XCTAssertNotNil(string)
        XCTAssertEqual("<script type=\"text/javascript\">\n</script>", string)
        
    }
    
    func testNotEmpty() {
        let string = htmlLoader.assembleJavascriptVariablesBlock(customVariables: [
            "Int" : 3,
            "Boolean" : true,
            "String" : "Alma",
            "Double": 3.4
        ])
        
        let textShouldBe = "<script type=\"text/javascript\">\n" +
            " var Boolean = true;\n" +
            " var Double = 3.4;\n" +
            " var Int = 3;\n" +
            " var String = \"Alma\";\n" +
        "</script>"
        
        XCTAssertNotNil(string)
        XCTAssertEqual(textShouldBe, string)
        
    }
}
