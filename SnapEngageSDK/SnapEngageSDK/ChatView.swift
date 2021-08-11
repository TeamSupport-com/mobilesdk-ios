//
//  ChatView.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 03..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation
import UIKit
import WebKit

/// ChatView - Wrapper view that hides the real implementation from the user and prevent to do any change on it.
public class ChatView: UIView, Chat {
    
    // MARK: - EventHandlers
    internal let closeEventHandler: CloseEventHandler = CloseEventHandlerImpl()
    internal let chatMessageReceivedEventHandler: ChatMessageReceivedEventHandler = ChatMessageReceivedEventHandlerImpl()
    internal let chatMessageSentEventHandler: ChatMessageSentEventHandler = ChatMessageSentEventHandlerImpl()
    internal let messageSubmitEventHandler: MessageSubmitEventHandler = MessageSubmitEventHandlerImpl()
    internal let minimizeEventHandler: MinimizeEventHandler = MinimizeEventHandlerImpl()
    internal let openEventHandler: OpenEventHandler = OpenEventHandlerImpl()
    internal let openProactiveEventHandler: OpenProactiveEventHandler = OpenProactiveEventHandlerImpl()
    internal let startChatEventHandler: StartChatEventHandler = StartChatEventHandlerImpl()
    internal let startCallmeEventHandler: StartCallmeEventHandler = StartCallmeEventHandlerImpl()
    internal let switchWidgetEventHandler: SwitchWidgetEventHandler = SwitchWidgetEventHandlerImpl()
    internal let buttonEventHandler: ButtonEventHandler = ButtonEventHandlerImpl()
    internal let onReadyEventHandler: OnReadyEventHandler = OnReadyEventHandlerImpl()
    internal let errorEventHandler = ErrorEventHandlerImpl()
    
    // MARK: - Variables
    
    /// This dictionary describes which eventHandler is responsible for a javaScript message
    private lazy var bridge: [String: WKScriptMessageHandler] = [
        "onCloseHandler": closeEventHandler,
        "chatMessageReceived": chatMessageReceivedEventHandler,
        "chatMessageSent": chatMessageSentEventHandler,
        "messageSubmit": messageSubmitEventHandler,
        "minimize": minimizeEventHandler,
        "open": openEventHandler,
        "openProactive": openProactiveEventHandler,
        "startChat": startChatEventHandler,
        "startCallme": startCallmeEventHandler,
        "switchWidget": switchWidgetEventHandler,
        "button": buttonEventHandler,
        "onReady": onReadyEventHandler,
        "error": errorEventHandler,
        "globalError": errorEventHandler
    ]
    
    private weak var webView: WKWebView?
    private var configuration: ChatConfiguration?
    private let htmlLoader = HtmlLoader()
    private let configurationValidator = ConfigurationValidator()
    
    /// The JavaScript actions are stored in this array, until the chat is ready, then they are executed
    private var pendingActions: [() -> Void?] = []
    
    // MARK: - Public
    
    ///  This variable represents that the chat has been loaded and ready to evaluate javascripts.
    @objc public private(set) var isReady: Bool = false
    
    /// When this variable is true, the SDK sets the underlying webview's isOpaque to false, and backgroundColor to clear
    @objc public var isWebViewTransparent: Bool = false {
        didSet {
            webView?.isOpaque = !isWebViewTransparent
            webView?.backgroundColor = isWebViewTransparent ? .clear : .white
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// You can get the status of the widget
    /// - Parameters:
    ///     - widgetId: Optional parameter, if it's nil, the ChatConfiguration's widgetId is used
    ///     - completion: Completion cloesure with a result parameter. The result can contain the WidgetAvailability or an Error, which can be a ChatError
    public func checkWidgetAvailability(widgetId: String? = nil, completion: @escaping (Result<WidgetAvailability, Error>) -> Void) {
        guard let config = self.configuration else {
            completion(.failure(ChatError.noChatConfiguration))
            return
        }
        
        let widgetId = widgetId ?? config.widgetId
        
        WidgetProvider(baseUrl: config.baseInstanceUrl).checkWidgetAvailability(widgetId: widgetId, completion: completion)
    }
    
    /// Setter to load a specific configuration to this View.
    /// - Parameters:
    ///     - configuration: ChatConfiguration that specifies the chat
    @objc public func setConfiguration(_ configuration: ChatConfiguration) {
        do {
            try configurationValidator.validate(configuration: configuration)
            self.configuration = configuration
            self.load(with: configuration)
        } catch {
            errorEventHandler.errorOccured(error: error)
        }
    }
    
    /// Shows the chat view, when the view is ready.
    /// - Parameters:
    ///     - resultCallback: Callback that invokes after the javascript evaluated.
    @objc public func startLink(completion: ChatViewActionCompletion? = nil) {
        self.runOrSaveJavaScriptOnProvider(script: "startLink();", completion: completion)
    }
    
    /// Show the chat button, when the view is ready.
    /// - Parameters:
    ///     - resultCallback: Callback that invokes after the javascript evaluated.
    @objc public func showButton(completion: ChatViewActionCompletion? = nil) {
        self.runOrSaveJavaScriptOnProvider(script: "showButton();", completion: completion)
    }
    
    /// Hides the chat button, when the view is ready.
    /// - Parameters:
    ///     - resultCallback: Callback that invokes after the javascript evaluated.
    @objc public func hideButton(completion: ChatViewActionCompletion? = nil) {
        self.runOrSaveJavaScriptOnProvider(script: "hideButton();", completion: completion)
    }
    
    /// Reloads the chat with the current configuration, sets the isReady property to false
    @objc public func reload() {
        self.isReady = false
        self.load(with: self.configuration)
    }
    
    ///  Clears the cookies, when the view is ready.
    /// - Parameters:
    ///     - resultCallback: Callback that invokes after the javascript evaluated.
    @objc public func clearAllCookies(completion: ChatViewActionCompletion? = nil) {
        self.runOrSaveJavaScriptOnProvider(script: "clearAllCookies();", completion: completion)
    }
    
    // MARK: - Private
    
    /// This method is called by both initializers
    private func commonInit() {
        let config = WKWebViewConfiguration()
        self.setupBridge(config: config)
        self.setupWebView(config: config)
        
        self.add(onReadyListener: self)
    }
    
    /// It registers every eventHandler to the webView
    private func setupBridge(config: WKWebViewConfiguration) {
        self.bridge.forEach { (key, messageHandler) in
            config.userContentController.add(messageHandler, name: key)
        }
    }
    
    /// It configures the webView for the desired behaviour
    /// - Parameters:
    ///     - config: WKWebViewConfiguration - Configuration of the WKWebView
    private func setupWebView(config: WKWebViewConfiguration) {
        let webView = WKWebView(frame: self.bounds, configuration: config)
        
        webView.navigationDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        webView.allowsLinkPreview = false
        
        webView.customUserAgent = WKWebView().value(forKey: "userAgent") as! String + " MobileSDK " + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
        
        self.webView = webView
        self.addSubview(webView)
    }
    
    /// It loads the chat with the given configuration
    /// - Parameters:
    ///     - configuration: ChatConfiguration that specifies the chat
    private func load(with configuration: ChatConfiguration?) {
        
        guard let configuration = configuration else {
            return
        }
        
        if let html = self.htmlLoader.loadHtml(with: configuration) {
            webView?.loadHTMLString(html, baseURL: configuration.entryPageUrl)
        }
    }
    
    /// If the chat is ready, it runs a javaScript on the chat.
    /// If the chat is not ready, it saves the action to the pendingActions variable
    /// It appends the provider prefix to the script.
    ///
    /// - Parameters:
    ///     - script: JavaScript without the provider prefix, that we would like to run
    ///     - completion: It's called when the action is executed, or when there is no ChatConfiguration
    private func runOrSaveJavaScriptOnProvider(script: String, completion: ChatViewActionCompletion? = nil) {
        guard let chatConfig = self.configuration else {
            completion?(nil, ChatError.noChatConfiguration)
            return
        }
        
        let scriptWithProvider = "\(chatConfig.provider)." + script
        
        let action = { [weak self] in
            self?.webView?.evaluateJavaScript(scriptWithProvider, completionHandler: completion)
        }
        
        if isReady {
            action()
        } else {
            self.pendingActions.append(action)
        }
    }
    
    /// It's called when the chat is ready, and runs the pending actions
    private func runPendingActions() {
        self.pendingActions.compactMap{ $0 }.forEach { (action) in
            action()
        }
    }
}

extension ChatView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let nsError = error as NSError
    
        //Below iOS 13 an error occured when the webview cancels to open the entryPageUrl
        if nsError.code == NSURLErrorCancelled {
            return
        }
        
        self.errorEventHandler.errorOccured(error: error)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.errorEventHandler.errorOccured(error: error)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}

extension ChatView: OnReadyEventListener {
    
    /// It's called when the JavaScript loaded successfully, sets the isReady to true, and runs the pending actions
    public func onReady() {
        self.isReady = true
        self.runPendingActions()
    }
}
