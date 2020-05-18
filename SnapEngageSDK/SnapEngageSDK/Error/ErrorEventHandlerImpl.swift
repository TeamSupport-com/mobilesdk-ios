//
//  ErrorEventHandlerImpl.swift
//  SnapEngageSDK
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import WebKit

/// Implementation of the ErrorEventHandler.
class ErrorEventHandlerImpl: BaseEventHandler<ErrorEventListener>, ErrorEventHandler {
    
    ///Removes the given ErrorEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ErrorEventListener) {
        self.listeners.removeAll(where: { $0.value === listener})
    }
    
    /// The SDK call this method when an error happened internally. It posted to all listeners
    /// - Parameters:
    ///     - error: The error object
    func errorOccured(error: Error) {
        self.listeners.forEach { (listener) in
            listener.value?.onError(error: error)
        }
    }
    /// Bridge method where the data comes from Javascript. It posted to all listeners
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let dict = message.body as? [String: AnyObject] else {
            return
        }
        
        switch message.name {
        case "globalError":
            let message = dict["message"] as? String
            self.errorOccured(error: ChatError.javaScriptError(message: message))
            
        default:
            self.errorOccured(error: ChatError.javaScriptCouldNotLoad)
        }
    }
}

extension ChatView {
    
    ///Adds the given ErrorEventListener to the ErrorEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    @objc public func add(errorListener: ErrorEventListener) {
        errorEventHandler.add(listener: errorListener)
    }
    
    ///Removes the given ErrorEventListener from the ErrorEventHandler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    @objc public func remove(errorListener: ErrorEventListener) {
        errorEventHandler.remove(listener: errorListener)
    }
}
