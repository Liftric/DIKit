# DIKit

Dependency Injection Framework for Swift.

> Nothing to see here right now.

## Basic usage

1. Define your dependencies.

```swift
import DIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DIKitProtocol {
    lazy var container = {
        return DependencyContainer { container in
        container.register(as: .singleton) { Network(url: "http://localhost") as NetworkProtocol }
        container.register(as: .singleton) { Backend(network: container.resolve()) as BackendProtocol }
        container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
        }
    }()
}

```

2. Resolve them.

```
swift
import DIKit

class FirstViewController: UIViewController {
    let backend = Dependency<BackendProtocol>()

    override func viewDidLoad() {
        super.viewDidLoad()
        DIKit.inject(into: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        if let result = backend.service?.fetch() {
            print(result)
        }
    }
}
```
