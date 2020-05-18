//
//  OnReadyEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by Kristof Varga on 2020. 04. 14..
//  Copyright © 2020. Attrecto. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of OnReadyEventHandler
class OnReadyEventHandlerImpl: BaseEventHandler<OnReadyEventListener>, OnReadyEventHandler {
    
    /// Removes the given OnReadyEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OnReadyEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.listeners.forEach { (listener) in
            listener.value?.onReady()
        }
    }
}

extension ChatView {
    
    /// Adds the given OnReadyEventListener to the onReadyEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(onReadyListener: OnReadyEventListener) {
        onReadyEventHandler.add(listener: onReadyListener)
    }
    
    /// Removes the given OnReadyEventListener from the onReadyEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(onReadyListener: OnReadyEventListener) {
        onReadyEventHandler.remove(listener: onReadyListener)
    }
}
