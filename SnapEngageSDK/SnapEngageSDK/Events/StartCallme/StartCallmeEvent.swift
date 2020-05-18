//
//  StartCallmeEvent.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for StartCallmeEvents.
@objc public protocol StartCallmeEventListener {
    
    ///The StartCallMe event is fired when the visitor starts a call-me.
    ///This callback can return one piece of info: the visitor's phone number.
    /// - Parameters:
    ///     - phone: The visitor's phone number.
    @objc func onStartCallme(phone: String?)
}

/// Abstraction of the start call me event handler
protocol StartCallmeEventHandler: EventHandler {
    
    ///Adds the given StartCallmeEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: StartCallmeEventListener)
    
    ///Removes the given StartCallmeEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: StartCallmeEventListener)
}
