//
//  StartChatEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for StartChatEvents.
@objc public protocol StartChatEventListener {
    
    /// The StartChat event is fired when the visitor starts a chat, or responds to a proactive invitation.
    /// This callback can return three pieces of info: the visitor's email, the visitor's first msg, and the type of chat (manual or proactive).
    /// - Parameters:
    ///     - email: The visitor's email address.
    ///     - msg: The visitor's first message.
    ///     - type: The type of chat.
    @objc func onStartChat(email: String?, message: String?, type: String?)
}

/// Abstraction of the start chat event handler
protocol StartChatEventHandler: EventHandler {
    
    ///Adds the given StartChatEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: StartChatEventListener)
    
    ///Removes the given StartChatEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: StartChatEventListener)
}
