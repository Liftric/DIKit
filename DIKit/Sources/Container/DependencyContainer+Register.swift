//
//  DependencyContainer+Register.swift
//  DIKit
//
//  Created by Ben John on 01.02.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

extension DependencyContainer {
    /// Registers a `Component`.
    ///
    /// - Parameters:
    ///     - scope: The *scope* of the `Component`, defaults to `Scope.prototype`.
    ///     - factory: The *factory* for the initialization of the `Component`.
    public func register<T>(as scope: Scope = .prototype, _ factory: @escaping () -> T) {
        precondition(!bootstrapped, "After boostrap no more components can be registered.")
        threadSafe {
            let component = Component(scope: scope, type: T.self, factory: factory)
            guard self.componentStack[component.tag] == nil else {
                fatalError("A component can only be registered once.")
            }
            self.componentStack[component.tag] = component
        }
    }
}
