//
//  Chat.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 14..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

public typealias ChatViewActionCompletion = (_ result: Any?, _ error: Error?) -> Void

/// Protocol, that summarizes the public API of the ChatView
protocol Chat {
    var isReady: Bool { get }
    func setConfiguration(_ configuration: ChatConfiguration)
    func startLink(completion: ChatViewActionCompletion?)
    func hideButton(completion: ChatViewActionCompletion?)
    func showButton(completion: ChatViewActionCompletion?)
    func clearAllCookies(completion: ChatViewActionCompletion?)
    func reload()
}
