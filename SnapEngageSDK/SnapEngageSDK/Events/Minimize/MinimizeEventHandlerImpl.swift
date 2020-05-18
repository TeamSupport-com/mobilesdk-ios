//
//  MinimizeEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the minimize event handler.
class MinimizeEventHandlerImpl: BaseEventHandler<MinimizeEventListener>, MinimizeEventHandler {
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: MinimizeEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        guard let isMinimized = dict["isMinimized"] as? Bool else {
            return
        }
        
        let chatType = dict["chatType"] as? String
        let boxType = dict["boxType"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onMinimize(isMinimized: isMinimized, chatType: chatType, boxType: boxType)
        }
    }
}

extension ChatView {
    
    ///Adds the given MinimizeEventListener to the MinimizeEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(minimizeListener: MinimizeEventListener) {
        minimizeEventHandler.add(listener: minimizeListener)
    }
    
    ///Removes the given MinimizeEventListener from the MinimizeEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(minimizeListener: MinimizeEventListener) {
        minimizeEventHandler.remove(listener: minimizeListener)
    }
}
