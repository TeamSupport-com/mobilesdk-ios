# SnapEngage Mobile SDK for iOS


###How to install the SDK?

Install the SDK using CocoaPods, by copying the following line in the Podfile:
```
pod 'SnapEngageSDK'
```


Import the SnapEngageSDK to your swift file:

```
import SnapEngageSDK
```

Instantiate a ChatView from code or StoryBoard:
```
let chatView = ChatView()
```

Configure the ChatView

Create a ChatConfiguration object with your parameters. The constructor supports an optional parameter called customVariables.
```
let config = ChatConfiguration(
url: URL(string: "https://url_of_the_js_file.js")!,
company: "SnapEngage",
entryPageUrl: URL(string: "https://your_home_page.com")!,
customVariables: [
            "name" : "John",
            "someothervariable"  : 12,
        ])
```

Setup the chatView with the configuration:
```
chatView.setConfiguration(config)
```

Register callbacks

You can observe several events of the SnapEngage chat by adding a listener to your chatView. You can add several listeners to the same event.
for example:

```
self.chatView.add(closeListener: self)

extension MyViewController: CloseEventListener {
	func onClose(type: String?, status: String?) {
		print("Chat closed")
	}
}

```

You can also remove a listener:
```
self.chatView.remove(closeListener: self)
```


