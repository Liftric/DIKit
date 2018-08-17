// ModalViewController.generated.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import DIKit

private typealias Dependency = ModalViewController.Dependency
extension Dependency: HasResolverContext {
    static var r: DependencyResolver = resolver()
    static func inject(into instance: ModalViewController) {
        instance.dependency = Dependency(
            backend: r.backend,
            localStorage: r.localStorage
        )
    }
}
