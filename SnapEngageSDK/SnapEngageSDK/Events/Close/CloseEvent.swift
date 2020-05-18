//
//  CloseEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 03..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for close events.
@objc public protocol CloseEventListener {
    
    /// The Close event is fired when a close button is clicked.
    /// This callback can return two pieces of info: type of window that was closed, and widget status when the close event was fired.
    ///  - Parameters:
    ///     - type: The type of window that was closed (see table of values below).
    ///     - status: The widget status when the close event was fired (see table of values below).
    @objc func onClose(type: String?, status: String?)
}

/// Abstraction of the close event handler.
protocol CloseEventHandler: EventHandler {
    
    ///Adds the given CloseEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: CloseEventListener)
    
    ///Removes the given CloseEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: CloseEventListener)
}
