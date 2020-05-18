//
//  SwitchWidgetEvent.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 07..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Listener for SwitchWidgetEvents.
@objc public protocol SwitchWidgetEventListener {
    
    /// The switchWidget event is triggered when the visitor has selected a value from the available dropdown list options. It will return the value of the newWidgetId.
    /// - Parameters:
    ///     - newWidgetId: The widgetId of the selected option.
    @objc func onSwitchWidget(newWidgetId: String?)
}

/// Abstraction of the switch widget event handler
protocol SwitchWidgetEventHandler: EventHandler {
    
    ///Adds the given SwitchWidgetEventListener to this handler.
    /// - Parameters:
    ///     - listener: the listener you want to register.
    func add(listener: SwitchWidgetEventListener)
    
    ///Removes the given SwitchWidgetEventListener from this handler.
    /// - Parameters:
    ///     - listener: the listener you want to remove.
    func remove(listener: SwitchWidgetEventListener)
}
