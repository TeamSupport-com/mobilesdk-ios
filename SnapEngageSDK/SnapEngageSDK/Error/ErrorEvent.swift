//
//  ErrorEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 17..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for error events.
@objc public protocol ErrorEventListener: AnyObject {
    
    /// onError event is fired, when an error happened, for example when the SDK couldn't load the chat
    /// - Parameters:
    ///     - error: The error object
    @objc func onError(error: Error)
}

/// Abstraction of the error event handler.
protocol ErrorEventHandler: EventHandler {
    
    ///Adds the given ErrorEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: ErrorEventListener)
    
    ///Removes the given ErrorEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ErrorEventListener)
}
