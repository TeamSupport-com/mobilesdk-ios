//
//  ChatMessageReceivedEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for chat message received events.
@objc public protocol ChatMessageReceivedEventListener {
    
    /// The ChatMessageReceived event is fired when a message from the agent is received by the visitor.
    /// This callback can return two pieces of info: name of the agent that sent the message, and the msg that was sent.
    /// - Parameters:
    ///     - agent: The agent alias.
    ///     - message: The message that was received by the visitor.
    @objc func onChatMessageReceived(agent: String?, message: String?)
}

/// Abstraction of the chat message received event handler.
protocol ChatMessageReceivedEventHandler: EventHandler {
    
    ///Adds the given ChatMessageReceivedEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: ChatMessageReceivedEventListener)
    
    ///Removes the given ChatMessageReceivedEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ChatMessageReceivedEventListener)
}
