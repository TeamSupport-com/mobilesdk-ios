//
//  MinimizeEvent.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for MinimizeEvents.
@objc public protocol MinimizeEventListener {
    
    ///The Minimize event is triggered when the visitor clicks the minimize icon in the chat box, or during live and active chats when they click on the minimized 'button' to maximize the chat box.
    /// - Parameters:
    ///     - isMinimized: The state of the chat box AFTER the visitor has clicked.
    ///     - chatType: The type of chat the visitor is using.
    ///     - boxType: The type of the chat box the visitor sees.
    @objc func onMinimize(isMinimized: Bool, chatType: String?, boxType: String?)
}

/// Abstraction of the minimize event handler.
protocol MinimizeEventHandler: EventHandler {
    
    ///Adds the given MinimizeEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: MinimizeEventListener)
    
    ///Removes the given MinimizeEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: MinimizeEventListener)
}
