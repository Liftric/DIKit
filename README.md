# DIKit

Dependency Injection Framework for Swift.

> Nothing to see here right now.

## Preconditions

- Your dependency container is built and lives in your `AppDelegate`.
- Your `AppDelegate` should implement `DIKitProtocol`.
- Define your dependencies via `Dependency<T>` as instance variables, prefixed with `__`.
- Let them be resolved via `DIKit.inject(into: Any)`, where `Any` should be an `NSObject` derivative.

You can also use the container straightforward without any injection magic:

```swift
let container = DependencyContainer { container in
    container.register(as: .singleton) { Network(url: "http://localhost") as NetworkProtocol }
}
let network: NetworkProtocol = container.resolve()
```

## Basic usage

1. Define your dependencies.

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

2. Resolve them.

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

## Known issues

- Sub containers are not supported, thus a more fine-grained modular composition is not possible yet.
- Lack of tests.
- Code generation missing.
