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
    /// - Returns: The resolved `Component<T>`.
    public func resolve<T>() -> T {
        let tag = String(describing: T.self)
        guard let foundComponent = self.componentStack[tag] else {
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
