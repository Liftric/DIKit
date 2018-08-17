# DIKit

Dependency Injection Framework for Swift, inspired by [KOIN](https://insert-koin.io/).

## Basic usage

1. Define a module:

2. Add DIKit to the AppDelegate:

```swift
import DIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DefinesContainer {
    let container = DependencyContainer { container in
        unowned let container = container
        container.register(as: .singleton) { Network(url: "http://localhost") as NetworkProtocol }
        container.register(as: .singleton) { Backend(network: container.resolve()) as BackendProtocol }
        container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
        container.register(as: .prototype) { Repository(backend: container.resolve(), storage: container.resolve()) as RepositoryProtocol }
    }
}
```

3. Inject the dependencies:

```swift
import DIKit

class FirstViewController: UIViewController, HasDependencies {
    // MARK: - Dependency declaration
    struct Dependency: HasContainerContext {
        let backend: BackendProtocol = container.resolve()
    }
    var dependency: Dependency! = Dependency()

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = dependency.backend.fetch()
        print(result)
    }
}
```
