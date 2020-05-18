//
//  MyViewController.swift
//  SnapEngage
//
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import UIKit
import SnapEngageSDK
class MyViewController: UIViewController {

    @IBOutlet weak var SnapEngageChat: ChatView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var hideLogButton: UIButton!
    @IBOutlet weak var logViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var logViewWidthConstraint: NSLayoutConstraint?
    
    private var isChatOpen = false {
        didSet {
            self.SnapEngageChat.isHidden = !isChatOpen
        }
    }
    
    private var isLogHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("saveConfig"), object: nil, queue: nil) { [weak self] (notification) in
            guard let config = notification.userInfo?["config"] as? ChatConfiguration else {
                return
            }
            
            self?.SnapEngageChat.setConfiguration(config)
            self?.reload()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        self.isChatOpen = false
        self.circleButton.isHidden = true
        self.updateLogVisibility(isHidden: true)

        SnapEngageChat.setConfiguration(ChatConfiguration(widgetId: "8e01c706-fb83-42b6-a96e-ec03bf2cab5c", baseJsUrl: URL(string: "https://storage.googleapis.com/code.snapengage.com/js")!, provider: "SnapEngage", entryPageUrl: URL(string: "https://example.com")!, baseInstanceUrl: URL(string: "https://www.snapengage.com/public/api/v2/chat")!, customVariables: [
            "name": "Kerim"
        ]))
        
        checkWidgetAvailability()
        
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
        
        self.SnapEngageChat.reload()
        self.SnapEngageChat.startLink()
    }
    
    @IBAction func clearCookies(_ sender: Any) {
        self.SnapEngageChat.clearAllCookies()
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
        if SnapEngageChat.isReady {
            self.SnapEngageChat.hideButton()
            self.SnapEngageChat.startLink()
            self.isChatOpen.toggle()
        }
    }
    
    private func addListeners() {
        SnapEngageChat.add(closeListener: self)
        SnapEngageChat.add(chatMessageReceivedListener: self)
        SnapEngageChat.add(chatMessageSentListener: self)
        SnapEngageChat.add(messageSubmitListener: self)
        SnapEngageChat.add(minimizeListener: self)
        SnapEngageChat.add(openListener: self)
        SnapEngageChat.add(openProactiveListener: self)
        SnapEngageChat.add(startChatListener: self)
        SnapEngageChat.add(startCallmeListener: self)
        SnapEngageChat.add(switchWidgetListener: self)
        SnapEngageChat.add(buttonListener: self)
        SnapEngageChat.add(errorListener: self)
        SnapEngageChat.add(onReadyListener: self)
    }
    
    private func reload() {
        self.checkWidgetAvailability()
        self.SnapEngageChat.reload()
        self.isChatOpen = false
    }
    
    private func checkWidgetAvailability() {
        SnapEngageChat.checkWidgetAvailability { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let widgetAvailability):
                    self?.circleButton.isHidden = !widgetAvailability.data.online
                case .failure(let error):
                    self?.errorHappened(error: error)
                }
            }
        }
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
    
    private func errorHappened(error: Error) {
        self.log(message: "\(#function) error: \(error)")
        
        let alert = UIAlertController(title: "Error", message: "Error happened: " + error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] (_) in
            self?.reload()
        }
        
        alert.addAction(okAction)
        alert.addAction(retryAction)
        
        self.present(alert, animated: true, completion: nil)
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
        self.errorHappened(error: error)
    }
}
