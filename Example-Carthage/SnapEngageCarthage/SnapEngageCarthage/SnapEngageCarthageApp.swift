//
//  SnapEngageCarthageApp.swift
//  SnapEngageCarthage
//
//  Created by Péter Rénes on 2022. 04. 07..
//

import SwiftUI
import SnapEngageSDK

@main
struct SnapEngageCarthageApp: App {
    
    init() {
        let snapEngageChat = ChatView()
        snapEngageChat.setConfiguration(
            ChatConfiguration(
                widgetId: "8e01c706-fb83-42b6-a96e-ec03bf2cab5c",
                baseJsUrl: URL(string: "https://storage.googleapis.com/code.snapengage.com/js")!,
                provider: "SnapEngage",
                entryPageUrl: URL(string: "https://example.com")!,
                baseInstanceUrl: URL(string: "https://www.snapengage.com/public/api/v2/chat")!,
                customVariables: [
                    "name" : "Kerim"
                ]
            )
         )
        NSLog("Sdk initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
