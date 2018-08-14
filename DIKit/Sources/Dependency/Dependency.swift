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
    func inject(with container: DependencyContainer)
}

public class Dependency<T>: DependencyProtocol {
    public var service: T?

    func inject(with container: DependencyContainer) {
        let resolvedService: T = container.resolve()
        self.service = resolvedService
    }

    public init() {}
}
