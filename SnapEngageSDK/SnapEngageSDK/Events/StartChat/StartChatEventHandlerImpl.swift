//
//  StartChatEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

class StartChatEventHandlerImpl: BaseEventHandler<StartChatEventListener>, StartChatEventHandler {
    
    ///Removes the given StartChatEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: StartChatEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let email = dict["email"] as? String
        let message = dict["msg"] as? String
        let type = dict["type"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onStartChat(email: email, message: message, type: type)
        }
    }
}

extension ChatView {
    
    ///Adds the given StartChatEventListener to the StartChatEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(startChatListener: StartChatEventListener) {
        startChatEventHandler.add(listener: startChatListener)
    }
    
    ///Removes the given StartChatEventListener from the StartChatEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(startChatListener: StartChatEventListener) {
        startChatEventHandler.remove(listener: startChatListener)
    }
}
