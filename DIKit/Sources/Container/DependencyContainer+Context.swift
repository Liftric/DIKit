// DependencyContainer+Context.swift
//
// - Authors:
// Ben John
//
// - Date: 21.10.19
//
// Copyright © 2019 Ben John. All rights reserved.

extension DependencyContainer {
    /// Defines the used `DependencyContainer` root for resolving components.
    /// Can can be statically resolved for injection.
    ///
    /// - Parameters:
    ///     - by: *DependencyContainer* the root `DependencyContainer`
    public static func defined(by root: DependencyContainer) {
        guard self.root == nil else {
            fatalError("It is not allowed to override the `root` DependencyContainer at runtime.")
        }
        self.root = root
    }
}
