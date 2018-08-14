// Dependency.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation

protocol DependencyProtocol {
    func inject(from container: DependencyContainer)
}

public class Dependency<T>: DependencyProtocol {
    public var get: T?

    func inject(from container: DependencyContainer) {
        let dependency: T = container.resolve()
        self.get = dependency
    }

    public init() {}
}
