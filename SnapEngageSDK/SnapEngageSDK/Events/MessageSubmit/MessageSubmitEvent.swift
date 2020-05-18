//
//  MessageSubmitEvent.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for MessageSubmit events.
@objc public protocol MessageSubmitEventListener {
    
    /// The MessageSubmit event is fired when the visitor submits an offline message (not a chat message).
    /// This callback can return two pieces of info: the visitor's email, and the message that was sent.
    ///  - Parameters:
    ///     - email: The visitor's email address.
    ///     - message: The message.
    @objc func onMessageSubmit(email: String?, message: String?)
}

/// Abstraction of the message submit event handler.
protocol MessageSubmitEventHandler: EventHandler {
    
    ///Adds the given MessageSubmitEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: MessageSubmitEventListener)
    
    ///Removes the given MessageSubmitEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: MessageSubmitEventListener)
}
