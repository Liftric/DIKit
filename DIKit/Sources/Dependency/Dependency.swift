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
    var _service: T?
    public var value: T! {
        guard _service != nil else {
            fatalError("You need to invoke `DIKit.inject(into: self)` before actually accessing a `Dependency` or your class does not inherit from `NSObject`.")
        }
        return _service
    }

    func inject(from container: DependencyContainer) {
        let dependency: T = container.resolve()
        self._service = dependency
    }

    public init() {}
}
