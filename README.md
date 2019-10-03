# DIKit 

## [![Build Status](https://app.bitrise.io/app/dc5ea4c384eb9b4a/status.svg?token=OjaZqMJaMx4HBb3JZEvoKQ&branch=master)](https://app.bitrise.io/app/dc5ea4c384eb9b4a) [![codecov](https://codecov.io/gh/JZDesign/DIKit/branch/master/graph/badge.svg)](https://codecov.io/gh/JZDesign/DIKit)



Dependency Injection Framework for Swift, inspired by [KOIN](https://insert-koin.io/). Basically an implementation of service-locator pattern, living within the application's context (through the `AppDelegate`).

> Grow as you go!

We started small, it perfectly fits our use case.

## Installation

### Via Carthage

DIKit can be installed using [Carthage](https://github.com/Carthage/Carthage). After installing Carthage just add DIKit to your Cartfile:

```ogdl
github "benjohnde/DIKit" ~> 1.1
```

### Via CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. After installing CocoaPods add DIKit to your Podfile:

```ruby
platform :ios, '9.0'
pod 'DIKit', '~> 1.1.0'
```

## Basic usage

1. Define a sub `DependencyContainer` (basically some sort of module declaration):
```swift
import DIKit

public extension DependencyContainer {
    static var backend = module {
        factory { Backend() as BackendProtocol }
    }
}

public extension DependencyContainer {
    static var network = module {
        single { Network() as NetworkProtocol }
    }
}
```

2. Let `AppDelegate` adhere `DefinesContainer`:
```swift
import DIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DefinesContainer {
    let container = modules { .backend; .network }
}
```

3. Inject the dependencies, for instance in a module:
```swift
import DIKit

class Backend: BackendProtocol {
    @Injectable var network: NetworkProtocol
}
```

or a `ViewController`:
```swift
import DIKit

class FirstViewController: UIViewController {
    // MARK: - Dependencies
    @Injectable var backend: BackendProtocol

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = backend.fetch()
        print(result)
    }
}
```
