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
    ///     - scope: The *scope* of the `Component`, defaults to `Lifetime.singleton`.
    ///     - factory: The *factory* for the initialization of the `Component`.
    public func register<T>(lifetime: Lifetime = .singleton, _ factory: @escaping () -> T) {
        precondition(!bootstrapped, "After boostrap no more components can be registered.")
        threadSafe {
            let component = Component(lifetime: lifetime, type: T.self, factory: factory)
            guard self.componentStack[component.tag] == nil else {
                fatalError("A component can only be registered once.")
            }
            self.componentStack[component.tag] = component
        }
    }

    public func register(_ component: ComponentProtocol) {
        precondition(!bootstrapped, "After boostrap no more components can be registered.")
        threadSafe {
            guard self.componentStack[component.tag] == nil else {
                fatalError("A component can only be registered once.")
            }
            self.componentStack[component.tag] = component
        }
    }
}
