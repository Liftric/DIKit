// DependencyContainer+Resolve.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


extension DependencyContainer {
    /// Resolves a `Component<T>`.
    ///
    /// - Parameters:
    ///     - scope: The associated *scope* of the Component as `String`.
    ///
    /// - Returns: The resolved `Component<T>`.
    public func resolve<T>(from scope: String = "") -> T {
        let tag = String(describing: T.self)
        guard let scopedComponentStack = self.componentStack[scope] else {
            fatalError("Scope is not valid for this DependencyContainer.")
        }
        guard let foundComponent = scopedComponentStack[tag] else {
            fatalError("Component `\(tag)` could not be resolved.")
        }
        if foundComponent.lifetime == .transient {
            return foundComponent.componentFactory() as! T
        }
        if let instanceOfComponent = self.instanceStack[tag] as? T {
            return instanceOfComponent
        }
        let instance = foundComponent.componentFactory() as! T
        self.instanceStack[tag] = instance
        return instance
    }
}
