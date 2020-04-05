// DependencyContainer+Resolve.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
// swiftlint:disable force_cast
// Copyright © 2018 Ben John. All rights reserved.

extension DependencyContainer {
    /// Resolves nil safe a `Component<T>`.
    ///
    /// - Returns: The resolved `Optional<Component<T>>`.
    func _resolve<T>() -> T? {
        let identifier = ComponentIdentifier(type: T.self)
        guard let foundComponent = self.componentStack[identifier] else {
            return nil
        }
        if foundComponent.lifetime == .factory {
            return foundComponent.componentFactory() as? T
        }
        if let instanceOfComponent = self.instanceStack[identifier] as? T {
            return instanceOfComponent
        }
        let instance = foundComponent.componentFactory() as! T
        self.instanceStack[identifier] = instance
        return instance
    }

    /// Checks whether `Component<T>` is resolvable by looking it up in the
    /// `componentStack`.
    ///
    /// - Parameters:
    ///     - type: The generic *type* of the `Component`.
    ///
    /// - Returns: `Bool` whether `Component<T>` is resolvable or not.
    func resolvable<T>(type: T.Type) -> Bool {
        let identifier = ComponentIdentifier(type: T.self)
        return self.componentStack[identifier] != nil
    }

    /// Resolves a `Component<T>`.
    /// Implicitly assumes that the `Component` can be resolved.
    /// Throws a fatalError if the `Component` is not registered.
    ///
    /// - Returns: The resolved `Component<T>`.
    public func resolve<T>() -> T {
        if let t: T = _resolve() {
            return t
        }
        fatalError("Component `\(String(describing: T.self))` could not be resolved.")
    }
}
