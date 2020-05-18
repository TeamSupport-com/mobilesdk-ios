//
//  CloseEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 03..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the close event handler.
class CloseEventHandlerImpl: BaseEventHandler<CloseEventListener>, CloseEventHandler {
    
    ///Removes the given CloseEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: CloseEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let type = dict["type"] as? String
        let status = dict["status"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onClose(type: type, status: status)
        }
    }
}

extension ChatView {
    
    ///Adds the given CloseEventListener to the CloseEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(closeListener: CloseEventListener) {
        closeEventHandler.add(listener: closeListener)
    }
    
    ///Removes the given CloseEventListener from the CloseEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(closeListener: CloseEventListener) {
        closeEventHandler.remove(listener: closeListener)
    }
}
