// DependencyContainer+Inject.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation

extension DependencyContainer {
    /// Injects all `[Dependency]`.
    ///
    /// In all instance variables which conform the `DependencyProtocol` the resolved
    /// `Component` gets injected.
    ///
    /// - Parameters:
    ///     - object: The *object* in which the `[Dependency]` are injected. Currently
    ///               only works for `NSObject` classes.
    public func inject(into object: NSObject) {
        let instanceVariables = Reflection.getInstanceVariables(for: object)
        instanceVariables.forEach { (name: String, value: Any) in
            guard let dependency = value as? DependencyProtocol else {
                return
            }
            // Dependency variable `name` was found, inject service.
            print("Dependency variable `\(name)` was found, inject service into `\(object)`.")
            dependency.inject(from: self)
        }
    }
}
