# SnapEngage Mobile SDK for iOS



###How to install the SDK?

Install the SDK using CocoaPods, by copying the following line in the Podfile:
```
pod 'SnapEngageSDK'
```

To install the SDK with Carthage, add the following line to your `Cartfile`.
```
github "SnapEngage/mobilesdk-ios" ~> 1.0
```


Import the SnapEngageSDK to your swift file:

```
import SnapEngageSDK
```

Instantiate a ChatView from code or StoryBoard:
```
let SnapEngageChat = ChatView()
```

Configure the ChatView

Create a ChatConfiguration object with your parameters. The constructor supports an optional parameter called customVariables.
```
SnapEngageChat.setConfiguration(
	ChatConfiguration(
		widgetId: "8e01c706-fb83-42b6-a96e-ec03bf2cab5c", 
		baseJsUrl: URL(string: "https://storage.googleapis.com/code.snapengage.com/js")!, 
		provider: "SnapEngage", 
		entryPageUrl: URL(string: "https://example.com")!, 
		baseInstanceUrl: URL(string: "https://www.snapengage.com/public/api/v2/chat")!, 
		customVariables: [
            "name" : "Kerim"
        ]
	)
 )
 ```


Register callbacks

You can observe several events of the SnapEngage chat by adding a listener to your chatView. You can add several listeners to the same event.
for example:

```
SnapEngageChat.add(closeListener: self)

extension MyViewController: CloseEventListener {
	func onClose(type: String?, status: String?) {
		print("Chat closed")
	}
}

```

You can also remove a listener:
```
SnapEngageChat.remove(closeListener: self)
```


