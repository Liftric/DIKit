// DependencyContainer.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


/// Container registry.
public final class DependencyContainer {
    // MARK: - Typealiases
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    typealias ComponentStack = [String: [String: ComponentProtocol]]
    typealias InstanceStack = [String: Any]

    // MARK: - Properties
    var bootstrapped = false
    var componentStack = ComponentStack()
    var instanceStack = InstanceStack()
    let lock = NSRecursiveLock()
    let scope: String

    // MARK: - Public methods
    /// Derives a `DependencyContainer` from multiple sub containers.
    ///
    /// - Parameters:
    ///     - from: *DependencyContainer...* to derive the final `DependencyContainer` from.
    ///
    /// - Returns: The final `DependencyContainer`.
    public static func derive(from containers: DependencyContainer...) -> DependencyContainer {
        return DependencyContainer(containers.reduce(into: ComponentStack()) { (result, container) in
            container.componentStack.forEach({ (key, value) in
                if var scopedComponentStack = result[key] {
                    scopedComponentStack.merge(value) { (old, new) -> ComponentProtocol in
                        fatalError("A `Component` was declared at least twice `\(old)` -> `\(new)` within the same `Scope` `\(container.scope)`.")
                    }
                    result[key] = scopedComponentStack
                } else {
                    result[key] = container.componentStack[key]
                }
            })
        })
    }

    /// Creates the `DependencyContainer`.
    ///
    /// - Parameters:
    ///     - scope: The associated *scope* of the Component as `String`.
    ///     - boostrapBlock: The *boostrapBlock* is a closure `(DependencyContainer)
    ///                       -> Void` for registering all `[Component]`.
    public init(scope: String = "", boostrapBlock: BootstrapBlock) {
        self.scope = scope
        self.componentStack[scope] = [String: ComponentProtocol]()
        threadSafe {
            boostrapBlock(self)
            self.bootstrapped = true
        }
    }

    // MARK: - Internal methods
    init(scope: String = "", _ componentStack: ComponentStack) {
        self.scope = scope
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
