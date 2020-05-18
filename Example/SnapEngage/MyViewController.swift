//
//  MyViewController.swift
//  SnapEngage
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import UIKit
import SnapEngageSDK
class MyViewController: UIViewController {

    @IBOutlet weak var chat: ChatView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var hideLogButton: UIButton!
    @IBOutlet weak var logViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var logViewWidthConstraint: NSLayoutConstraint?
    
    private var isChatOpen = false {
        didSet {
            self.chat.isHidden = !isChatOpen
        }
    }
    
    private var isLogHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("saveConfig"), object: nil, queue: nil) { [weak self] (notification) in
            guard let config = notification.userInfo?["config"] as? ChatConfiguration else {
                return
            }
            
            self?.chat.setConfiguration(config)
            self?.reload()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        self.isChatOpen = false
        
        self.updateLogVisibility(isHidden: true)

        chat.setConfiguration(ChatConfiguration(jsUrl: URL(string: "https://storage.googleapis.com/code.snapengage.com/js/8e01c706-fb83-42b6-a96e-ec03bf2cab5c.js")!, provider: "SnapEngage", entryPageUrl: URL(string: "https://example.com")!, customVariables: [
            "name" : "Kerim"
        ]))
        
        self.addListeners()
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated() {
        self.updateLogVisibility(isHidden: isLogHidden)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.chat.reload()
        self.chat.startLink()
    }
    
    @IBAction func clearCookies(_ sender: Any) {
        self.chat.clearAllCookies()
        self.reload()
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        self.reload()
    }
    
    @IBAction func toggleLogIsHidden(_ sender: Any) {
        self.updateLogVisibility(isHidden: !isLogHidden)
    }
    
    @IBAction func clearLog(_ sender: Any) {
        self.textView.text = ""
    }
    
    @IBAction func circleButtonPressed(_ sender: Any) {
        if chat.isReady {
            self.chat.hideButton()
            self.chat.startLink()
            self.isChatOpen.toggle()
        }
    }
    
    private func addListeners() {
        chat.add(closeListener: self)
        chat.add(chatMessageReceivedListener: self)
        chat.add(chatMessageSentListener: self)
        chat.add(messageSubmitListener: self)
        chat.add(minimizeListener: self)
        chat.add(openListener: self)
        chat.add(openProactiveListener: self)
        chat.add(startChatListener: self)
        chat.add(startCallmeListener: self)
        chat.add(switchWidgetListener: self)
        chat.add(buttonListener: self)
        chat.add(errorListener: self)
        chat.add(onReadyListener: self)
    }
    
    private func reload() {
        self.chat.reload()
        self.isChatOpen = false
    }
    
    private func log(message: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let formattedMessage = dateFormatter.string(from: Date()) + " - " + message
        print(formattedMessage)
        self.textView.text = self.textView.text + "\n" + formattedMessage
        
        let bottomOffset = CGPoint(x: 0, y: textView.contentSize.height - textView.bounds.size.height)
        textView.setContentOffset(bottomOffset, animated: true)
    }
    
    private func updateLogVisibility(isHidden: Bool) {
        self.isLogHidden = isHidden
        self.logViewHeightConstraint?.constant = isLogHidden ? 0 : 100
        self.logViewWidthConstraint?.constant = isLogHidden ? 0 : 200
        self.hideLogButton.setTitle(isLogHidden ? "Show log" : "Hide log", for: .normal)
    }
}

extension MyViewController: CloseEventListener {
    func onClose(type: String?, status: String?) {
        self.log(message: "\(#function) status: \(status ?? "") type: \(type ?? "")")
        self.isChatOpen = false
    }
}

extension MyViewController: ChatMessageReceivedEventListener {
    func onChatMessageReceived(agent: String?, message: String?) {
        self.log(message: "\(#function) agent: \(agent ?? "") message: \(message ?? "")")
    }
}

extension MyViewController: ChatMessageSentEventListener {
    func onChatMessageSent(message: String?) {
        self.log(message: "\(#function) message: \(message ?? "")")
    }
}

extension MyViewController: MessageSubmitEventListener {
    func onMessageSubmit(email: String?, message: String?) {
        self.log(message: "\(#function) email: \(email ?? "") message: \(message ?? "")")
    }
}

extension MyViewController: MinimizeEventListener {
    func onMinimize(isMinimized: Bool, chatType: String?, boxType: String?) {
        self.log(message: "\(#function) isMinimized: \(isMinimized) chatType: \(chatType ?? "") boxType: \(boxType ?? "")")
        
        if isMinimized == true {
            self.isChatOpen = false
        }
    }
}

extension MyViewController: OpenEventListener {
    func onOpen(status: String?) {
        self.log(message: "\(#function) status: \(status ?? "")")
    }
}

extension MyViewController: OpenProactiveEventListener {
    func onOpenProactive(agent: String?, message: String?) {
        self.log(message: "\(#function) agent: \(agent ?? "") message: \(message ?? "")")
    }
}

extension MyViewController: StartChatEventListener {
    func onStartChat(email: String?, message: String?, type: String?) {
        self.log(message: "\(#function) email: \(email ?? "") message: \(message ?? "") type: \(type ?? "")")
    }
}

extension MyViewController: StartCallmeEventListener {
    func onStartCallme(phone: String?) {
        self.log(message: "\(#function) phone: \(phone ?? "")")
    }
}

extension MyViewController: SwitchWidgetEventListener {
    func onSwitchWidget(newWidgetId: String?) {
        self.log(message: "\(#function) newWidgetId: \(newWidgetId ?? "")")
    }
}

extension MyViewController: ButtonEventListener {
    func onButton(options: ButtonEventOptions) {
        self.log(message: "\(#function) options: \(options)")
    }
}

extension MyViewController: OnReadyEventListener {
    func onReady() {
        self.log(message: "\(#function)")
    }
}

extension MyViewController: ErrorEventListener {
    func onError(error: Error) {
        self.log(message: "\(#function) error: \(error)")
        
        let alert = UIAlertController(title: "Error", message: "Error happened: " + error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] (_) in
            self?.chat.reload()
        }
        
        alert.addAction(okAction)
        alert.addAction(retryAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
