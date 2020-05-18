//
//  ButtonEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for ButtonEvents.
@objc public protocol ButtonEventListener {
    /// The InlineButtonClicked event is fired when the visitor clicks on messages that are buttons.
    /// - Parameters:
    ///     - options: Object containing information about the button that got clicked.
    @objc func onButton(options: ButtonEventOptions)
}

/// Object containing information about the button that got clicked.
@objc public class ButtonEventOptions: NSObject {

    /// Bot name (alias) that sent button message
    public let botName: String?
    
    /// Label of the button
    public let buttonLabel: String?
    
    /// Value of the button
    public let buttonValue: String?

    public init(botName: String?, buttonLabel: String?, buttonValue: String?) {
        self.botName = botName
        self.buttonLabel = buttonLabel
        self.buttonValue = buttonValue
    }
}

/// Abstraction of the button event handler.
protocol ButtonEventHandler: EventHandler {
    
    ///Adds the given ButtonEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: ButtonEventListener)
    
    ///Removes the given ButtonEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: ButtonEventListener)
}
