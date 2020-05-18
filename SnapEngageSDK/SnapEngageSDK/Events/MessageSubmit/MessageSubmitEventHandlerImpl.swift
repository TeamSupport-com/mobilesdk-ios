//
//  MessageSubmitEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the message submit event handler.
class MessageSubmitEventHandlerImpl: BaseEventHandler<MessageSubmitEventListener>, MessageSubmitEventHandler {
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: MessageSubmitEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let email = dict["agent"] as? String
        let message = dict["msg"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onMessageSubmit(email: email, message: message)
        }
    }
}

extension ChatView {
    
    ///Adds the given MessageSubmitEventListener to the MessageSubmitEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(messageSubmitListener: MessageSubmitEventListener) {
        messageSubmitEventHandler.add(listener: messageSubmitListener)
    }
    
    ///Removes the given MessageSubmitEventListener from the MessageSubmitEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(messageSubmitListener: MessageSubmitEventListener) {
        messageSubmitEventHandler.remove(listener: messageSubmitListener)
    }
}
