// DependencyContainer.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

import Foundation

/// Container registry.
public final class DependencyContainer {
    // MARK: - Typealiases
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    internal typealias ComponentStack = [AnyHashable: ComponentProtocol]
    internal typealias InstanceStack = [AnyHashable: Any]

    // MARK: - Properties
    internal var bootstrapped = false
    internal var componentStack = ComponentStack()
    internal var instanceStack = InstanceStack()
    private let lock = NSRecursiveLock()

    internal static var root: DependencyContainer?
    public static var shared: DependencyContainer {
        guard let root = DependencyContainer.root else {
            fatalError("`root` DependencyContainer is not yet set.")
        }
        return root
    }

    // MARK: - Public methods
    /// Derives a `DependencyContainer` from multiple sub containers.
    ///
    /// - Parameters:
    ///     - from: *DependencyContainer...* to derive the final `DependencyContainer` from.
    ///
    /// - Returns: The final `DependencyContainer`.
    public static func derive(from containers: DependencyContainer...) -> DependencyContainer {
        return DependencyContainer(containers.reduce(into: ComponentStack()) { (result, container) in
            result.merge(container.componentStack) { (old, new) -> ComponentProtocol in
                fatalError("A `Component` was declared at least twice `\(old)` -> `\(new)`.")
            }
        })
    }

    /// Derives a `DependencyContainer` from multiple sub containers.
    ///
    /// - Parameters:
    ///     - from: *[DependencyContainer]* to derive the final `DependencyContainer` from.
    ///
    /// - Returns: The final `DependencyContainer`.
    public static func derive(from containers: [DependencyContainer]) -> DependencyContainer {
        return DependencyContainer(containers.reduce(into: ComponentStack()) { (result, container) in
            result.merge(container.componentStack) { (old, new) -> ComponentProtocol in
                fatalError("A `Component` was declared at least twice `\(old)` -> `\(new)`.")
            }
        })
    }

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

    // MARK: - Internal methods
    init(_ componentStack: ComponentStack) {
        self.componentStack = componentStack
        self.bootstrapped = true
    }

    func threadSafe(_ closure: () -> ()) {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
}
