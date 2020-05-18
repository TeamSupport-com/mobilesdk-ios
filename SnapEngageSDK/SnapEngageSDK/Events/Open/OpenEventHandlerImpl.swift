//
//  OpenEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the open event handler.
class OpenEventHandlerImpl: BaseEventHandler<OpenEventListener>, OpenEventHandler {
    
    ///Removes the given OpenEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OpenEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let status = dict["status"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onOpen(status: status)
        }
    }
}

extension ChatView {
    
    ///Adds the given OpenEventListener to the OpenEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(openListener: OpenEventListener) {
        openEventHandler.add(listener: openListener)
    }
    
    ///Removes the given OpenEventListener from the OpenEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(openListener: OpenEventListener) {
        openEventHandler.remove(listener: openListener)
    }
}
