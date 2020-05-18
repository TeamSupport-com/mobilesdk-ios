//
//  SwitchWidgetEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

class SwitchWidgetEventHandlerImpl: BaseEventHandler<SwitchWidgetEventListener>, SwitchWidgetEventHandler {
    
    ///Removes the given SwitchWidgetEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: SwitchWidgetEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// Bridge method where the data comes from Javascript. It posted to all listeners 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        let newWidgetId = dict["newWidgetId"] as? String
        
        self.listeners.forEach { (listener) in
            listener.value?.onSwitchWidget(newWidgetId: newWidgetId)
        }
    }
}

extension ChatView {
    
    ///Adds the given SwitchWidgetEventListener to the SwitchWidgetEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(switchWidgetListener: SwitchWidgetEventListener) {
        switchWidgetEventHandler.add(listener: switchWidgetListener)
    }
    
    ///Removes the given SwitchWidgetEventListener from the SwitchWidgetEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(switchWidgetListener: SwitchWidgetEventListener) {
        switchWidgetEventHandler.remove(listener: switchWidgetListener)
    }
}
