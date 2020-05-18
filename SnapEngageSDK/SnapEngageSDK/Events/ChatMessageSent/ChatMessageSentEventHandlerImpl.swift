//
//  ChatMessageSentEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the chat message sent event handler.
class ChatMessageSentEventHandlerImpl: BaseEventHandler<ChatMessageSentEventListener>, ChatMessageSentEventHandler {
    
    ///Removes the given ChatMessageSentEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ChatMessageSentEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let message = dict["msg"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onChatMessageSent(message: message)
        }
    }
}

extension ChatView {
    
    ///Adds the given ChatMessageSentEventListener to the ChatMessageSentEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(chatMessageSentListener: ChatMessageSentEventListener) {
        chatMessageSentEventHandler.add(listener: chatMessageSentListener)
    }
    
    ///Removes the given ChatMessageSentEventListener from the ChatMessageSentEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(chatMessageSentListener: ChatMessageSentEventListener) {
        chatMessageSentEventHandler.remove(listener: chatMessageSentListener)
    }
}
