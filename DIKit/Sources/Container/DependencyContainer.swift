//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

typealias ComponentStack = [String: ComponentProtocol]

public final class DependencyContainer {
    var bootstrapped = false
    var componentStack = ComponentStack()
    var instanceStack = [String: Any]()
    let lock = NSRecursiveLock()

    /// Derives a `DependencyContainer` from multiple sub containers.
    ///
    /// - Parameters:
    ///     - containers: *DependencyContainer...*.
    /// TODO
    public static func derive(containers: DependencyContainer...) -> DependencyContainer {
        return DependencyContainer(containers.reduce(into: ComponentStack()) { (result, container) in
            result.merge(container.componentStack) { (old, new) -> ComponentProtocol in
                fatalError("A Component was declared at least twice `\(old)` -> `\(new)`.")
            }
        })
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
