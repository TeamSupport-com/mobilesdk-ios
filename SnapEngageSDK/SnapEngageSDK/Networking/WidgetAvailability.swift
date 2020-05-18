//
//  WidgetAvailability.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 30..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

public struct WidgetAvailability: Codable {
    public let statusCode: Int
    public let data: Data
    
    public struct Data: Codable {
        public let widgetId: String
        public let online: Bool
        public let emailRequired: Bool
        public let messageRequired: Bool
        public let screenshotRequired: Bool
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            widgetId = try values.decode(String.self, forKey: .widgetId)
            online = try values.decode(String.self, forKey: .online) == "true"
            emailRequired = try values.decode(String.self, forKey: .emailRequired) == "true"
            messageRequired = try values.decode(String.self, forKey: .messageRequired) == "true"
            screenshotRequired = try values.decode(String.self, forKey: .screenshotRequired) == "true"
        }
    }
}
