# DIKit

Dependency Injection Framework for Swift, inspired by [KOIN](https://insert-koin.io/). Basically an implementation of service-locator pattern, living within the application's context.

> Grow as you go!

We started small, it perfectly fits our use case.

## Installation

### Via Carthage

DIKit can be installed using [Carthage](https://github.com/Carthage/Carthage). After installing Carthage just add DIKit to your Cartfile:

```ogdl
github "Liftric/DIKit" ~> 1.6
```

### Via CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. After installing CocoaPods add DIKit to your Podfile:

```ruby
platform :ios, '9.0'
pod 'DIKit', '~> 1.6'
```

## Basic usage

1. Define some sub `DependencyContainer` (basically some sort of module declaration):
```swift
import DIKit

public extension DependencyContainer {
    static var backend = module {
        single { Backend() as BackendProtocol }
    }
}

public extension DependencyContainer {
    static var network = module {
        single { Network() as NetworkProtocol }
    }
}

public extension DependenyContainer {
    static var app = module {
        single { AppState() as AppStateProtocol }
        factory { StopWatch() as StopWatchProtocol }
    }
}
```

2. Set the root `DependencyContainer` and set it before the application gets initialised:
```swift
import DIKit

@UIApplicationMain
class AppDelegate: UIApplicationDelegate {
    override init() {
        super.init()
        DependencyContainer.defined(by: modules { .backend; .network; .app })
    }
}
```

Without sub `DependencyContainer` the following shorthand writing also does the job:

```swift
import DIKit

@UIApplicationMain
class AppDelegate: UIApplicationDelegate {
    override init() {
        super.init()
        DependencyContainer.defined(by: module {
            single { AppState() as AppStateProtocol }
            factory { StopWatch() as StopWatchProtocol }
        })
    }
}
```

3. Inject the dependencies, for instance in a module:
```swift
import DIKit

class Backend: BackendProtocol {
    @Inject var network: NetworkProtocol
}
```

or a `ViewController`:
```swift
import DIKit

class FirstViewController: UIViewController {
    // MARK: - Dependencies
    @LazyInject var backend: BackendProtocol
    @OptionalInject var stopwatch: StopWatchProtocol?

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = backend.fetch()
        print(result)
    }
}
```

Injection via constructor:

```swift
import DIKit

struct AppState: AppStateProtocol {
    private let backend: BackendProtocol
    init(backend: BackendProtocol = resolve()) {
        self.backend = backend
    }
}
```

## Advanced usage
### Resolving by Tag

When registering your dependencies you can optionally define a tag. The tag can be anything, as long as it is `AnyHashable`.

This way you can register different resolvable dependencies for the same Type.

```swift
enum StorageContext: String {
    case userdata
    case systemdata
}

public extension DependencyContainer {
    static var app = module {
        factory(tag: StorageContext.systemdata) { LocalStorage() as LocalStorageProtocol }
        factory(tag: StorageContext.userdata) { LocalStorage() as LocalStorageProtocol }
    }
}
```

You can then reference the same tag when resolving the type and can thus resolve different instances. Referencing the tag works with all injection methods.

```swift
import DIKit

class Backend: BackendProtocol {
    @Inject(tag: StorageContext.systemdata) var injectedStorage: LocalStorageProtocol
    @LazyInject(tag: StorageContext.systemdata) var lazyInjectedStorage: LocalStorageProtocol
    @OptionalInject(tag: StorageContext.systemdata) var optionalInjectedStorage: LocalStorageProtocol?
    
    private let constructorInjectedStorage: LocalStorageProtocol
    init(storage: LocalStorageProtocol = resolve(tag: StorageContext.systemdata)) {
        self.constructorInjectedStorage = storage
    }
}
```
