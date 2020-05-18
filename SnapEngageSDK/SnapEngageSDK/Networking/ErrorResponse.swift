//
//  ErrorResponse.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 05. 05..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let statusCode: Int
    let error: ErrorResponse.Error

    struct Error: Codable {
        let message: String
    }
}
