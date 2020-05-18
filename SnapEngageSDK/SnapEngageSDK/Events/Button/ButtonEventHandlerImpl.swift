//
//  ButtonEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the ButtonEventHandler.
class ButtonEventHandlerImpl: BaseEventHandler<ButtonEventListener>, ButtonEventHandler {
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ButtonEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let botName = dict["botName"] as? String
        let buttonLabel = dict["buttonLabel"] as? String
        let buttonValue = dict["buttonValue"] as? String

        
        let options = ButtonEventOptions(botName: botName, buttonLabel: buttonLabel, buttonValue: buttonValue)
        
        self.listeners.forEach { (listener) in
            listener.value?.onButton(options: options)
        }
    }
}

extension ChatView {
    
    /// Adds the given ButtonEventListener to the onReadyEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(buttonListener: ButtonEventListener) {
        buttonEventHandler.add(listener: buttonListener)
    }
    
    /// Removes the given ButtonEventListener from the onReadyEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(buttonListener: ButtonEventListener) {
        buttonEventHandler.remove(listener: buttonListener)
    }
}
