//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

typealias ComponentStack = [String: ComponentProtocol]

public final class DependencyContainer {
    var bootstrapped = false
    var componentStack = [String: ComponentProtocol]()
    var instanceStack = [String: Any]()
    let lock = NSRecursiveLock()

    public static func derive(containers: DependencyContainer...) -> DependencyContainer {
//        containers.reduce(into: [String: ComponentProtocol]) { (result: inout [String: ComponentProtocol], container) in
//            container.componentStack.merge(result, uniquingKeysWith: { (a, b) -> ComponentProtocol in
//                return true
//            })
//            componentStack.append(contentsOf: container.componentStack)
//        }
        var componentStack = [String: ComponentProtocol]()
        containers.forEach { container in
            componentStack += container.componentStack
        }
        return DependencyContainer(componentStack)
    }
    
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    /// Creates the `DependencyContainer`.
    ///
    /// - Parameters:
    ///     - boostrapBlock: The *boostrapBlock* is a closure `(DependencyContainer)
    ///                       -> Void` for registering all `[Component]`.
    public init(boostrapBlock: BootstrapBlock) {
        threadSafe {
            boostrapBlock(self)
            self.bootstrapped = true
        }
    }

    init(_ componentStack: ComponentStack) {
        self.componentStack = componentStack
        self.bootstrapped = true
    }
    
    func threadSafe(_ closure: () -> ()) -> () {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
}
