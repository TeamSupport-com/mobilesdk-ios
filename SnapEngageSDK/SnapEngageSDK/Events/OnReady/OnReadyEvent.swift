//
//  OnReadyEvent.swift
//  SnapEngageSDK
//
//  Created by Kristof Varga on 2020. 04. 14..
//  Copyright © 2020. Attrecto. All rights reserved.
//

import Foundation

/// Listener for onReady events
@objc public protocol OnReadyEventListener {
    /// onReady events fires when the chat loaded and ready to use
    @objc func onReady()
}

/// Abstraction of the ready event handler.
protocol OnReadyEventHandler: EventHandler {
    
    /// Adds the given OnReadyEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: OnReadyEventListener)
    
    /// Removes the given OnReadyEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OnReadyEventListener)
}
