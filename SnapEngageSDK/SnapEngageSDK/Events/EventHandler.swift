//
//  EventHandler.swift
//  SnapEngageSDK
//
//  Created by Kristof Varga on 2020. 04. 03..
//  Copyright © 2020. Attrecto. All rights reserved.
//

import Foundation
import WebKit

/// Base protocol for EventHandlers
protocol EventHandler: WKScriptMessageHandler {
    
}

// MARK: -

/// Super class of every EventHandler
class BaseEventHandler<Listener>: NSObject where Listener: AnyObject {
    
    /// The listeners are stored in this array
    var listeners: [WeakRef<Listener>] = []
    
    
    /// Add a new listener
    /// - Parameters:
    ///     - listener: A generic listener
    func add(listener: Listener) {
        self.listeners.append(WeakRef(value: listener))
    }
}

/// A helper class to store weak references in an array
class WeakRef<T> where T: AnyObject {

    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}
