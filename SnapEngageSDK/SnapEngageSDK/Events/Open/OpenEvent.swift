//
//  OpenEvent.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for OpenEvents.
@objc public protocol OpenEventListener {
    
    /// The Open event is fired when the chat form is opened. The form may be opened by the user directly (button click), or as the result of an API call.
    /// This callback can return one piece of info: the widget status when the event was fired.
    /// - Parameters:
    ///     - status: The widget status at the time the event was fired.
    @objc func onOpen(status: String?)
}

/// Abstraction of the open event handler.
protocol OpenEventHandler: EventHandler {
    
    ///Adds the given OpenEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: OpenEventListener)
    
    ///Removes the given OpenEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OpenEventListener)
}
