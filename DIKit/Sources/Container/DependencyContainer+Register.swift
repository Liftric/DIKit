// DependencyContainer+Register.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

extension DependencyContainer {
    /// Registers a `Component`.
    ///
    /// - Parameters:
    ///     - lifetime: The *scope* of the `Component`, defaults to `Lifetime.singleton`.
    ///     - factory: The *factory* for the initialization of the `Component`.
    public func register<T>(lifetime: Lifetime = .singleton, _ factory: @escaping () -> T) {
        let component = Component(lifetime: lifetime, factory: factory)
        register(component)
    }

    /// Registers a `Component`
    ///
    /// - Parameters:
    ///   - lifetime: The *scope* of the `Component`, defaults to `Lifetime.singleton`.
    ///   - tag: A *tag* for the `Component` used to identify it.
    ///   - factory: The *factory* for the initialization of the `Component`.
    public func register<T>(lifetime: Lifetime = .singleton, tag: AnyHashable, _ factory: @escaping () -> T) {
        let component = Component(lifetime: lifetime, tag: tag, factory: factory)
        register(component)
    }

    public func register(_ component: ComponentProtocol) {
        precondition(!bootstrapped, "After boostrap no more components can be registered.")
        threadSafe {
            guard self.componentStack[component.identifier] == nil else {
                fatalError("A component can only be registered once.")
            }
            self.componentStack[component.identifier] = component
        }
    }
}
