//
//  OpenProactiveEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

class OpenProactiveEventHandlerImpl: BaseEventHandler<OpenProactiveEventListener>, OpenProactiveEventHandler {
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: OpenProactiveEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let agent = dict["agent"] as? String
        let message = dict["msg"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onOpenProactive(agent: agent, message: message)
        }
    }
}

extension ChatView {
    
    ///Adds the given OpenProactiveEventListener to the OpenProactiveEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(openProactiveListener: OpenProactiveEventListener) {
        openProactiveEventHandler.add(listener: openProactiveListener)
    }
    
    ///Removes the given OpenProactiveEventListener from the OpenProactiveEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(openProactiveListener: OpenProactiveEventListener) {
        openProactiveEventHandler.remove(listener: openProactiveListener)
    }
}
