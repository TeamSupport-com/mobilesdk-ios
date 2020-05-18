//
//  StartCallmeEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

class StartCallmeEventHandlerImpl: BaseEventHandler<StartCallmeEventListener>, StartCallmeEventHandler {
    
    ///Removes the given StartCallmeEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: StartCallmeEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let phone = dict["phone"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onStartCallme(phone: phone)
        }
    }
}

extension ChatView {
    
    ///Adds the given StartCallmeEventListener to the SwitchWidgetEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(startCallmeListener: StartCallmeEventListener) {
        startCallmeEventHandler.add(listener: startCallmeListener)
    }
    
    ///Removes the given StartCallmeEventListener from the SwitchWidgetEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(startCallmeListener: StartCallmeEventListener) {
        startCallmeEventHandler.remove(listener: startCallmeListener)
    }
}
