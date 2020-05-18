//
//  ChatMessageReceivedEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the chat message received event handler.
class ChatMessageReceivedEventHandlerImpl: BaseEventHandler<ChatMessageReceivedEventListener>, ChatMessageReceivedEventHandler {
    
    ///Removes the given ChatMessageReceivedEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ChatMessageReceivedEventListener) {
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
            listener.value?.onChatMessageReceived(agent: agent, message: message)
        }
    }
}

extension ChatView {
    
    ///Adds the given ChatMessageReceivedEventListener to the ChatMessageReceivedEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(chatMessageReceivedListener: ChatMessageReceivedEventListener) {
        chatMessageReceivedEventHandler.add(listener: chatMessageReceivedListener)
    }
    
    ///Removes the given ChatMessageReceivedEventListener from the ChatMessageReceivedEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(chatMessageReceivedListener: ChatMessageReceivedEventListener) {
        chatMessageReceivedEventHandler.remove(listener: chatMessageReceivedListener)
    }
}
