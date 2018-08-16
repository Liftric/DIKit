// FirstViewController.generated.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation
import DIKit

typealias Dependency = FirstViewController.Dependency
extension Dependency: HasContainerContext {
    static func inject(into instance: FirstViewController) {
        instance.dependency = Dependency(
            backend: container.resolve(),
            localStorage: container.resolve()
        )
    }
}
