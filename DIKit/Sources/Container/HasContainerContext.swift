// HasContainerContext.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

public protocol HasContainerContext {
    var container: DependencyContainer { get }
}

public extension HasContainerContext {
    var container: DependencyContainer {
        return DIKit.shared.container
    }
}
