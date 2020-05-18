//
//  OpenProactiveEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for OpenProactiveEvents.
@objc public protocol OpenProactiveEventListener {
    
    /// The OpenProactive event is fired when the proactive chat is displayed to a visitor. (Note, when the visitor replies, the StartChat even/// fires.)
    /// This callback can return two pieces of info: the name of the agent used in the proactive message, and the proactive msg itself.
    /// - Parameters:
    ///     - agent: the agent alias.
    ///     - msg: the proactive prompt message.
    @objc func onOpenProactive(agent: String?, message: String?)
}

/// Abstraction of the open proactive event handler
protocol OpenProactiveEventHandler: EventHandler {
    
    ///Adds the given ButtonEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: OpenProactiveEventListener)
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OpenProactiveEventListener)
}
