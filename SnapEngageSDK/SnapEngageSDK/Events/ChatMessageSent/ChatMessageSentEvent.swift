//
//  ChatMessageSentEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for ChatMessageSent events.
@objc public protocol ChatMessageSentEventListener {
    
    /// The ChatMessageSent event is fired when the visitor submits a chat message while in the chat session.
    /// This callback can return one piece of info: the msg that was sent by the visitor.
    ///  - Parameters:
    ///     - message: The message that was sent by the visitor.
    @objc func onChatMessageSent(message: String?)
}

/// Abstraction of the chat message sent event handler.
protocol ChatMessageSentEventHandler: EventHandler {
    
    ///Adds the given ChatMessageSentEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: ChatMessageSentEventListener)
    
    ///Removes the given ChatMessageSentEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ChatMessageSentEventListener)
}
