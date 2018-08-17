// HasContainerContext.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

public protocol HasContainerContext {
    static var container: DependencyContainer { get }
}

public extension HasContainerContext {
    static var container: DependencyContainer {
        return DIKit.shared.container
    }
}
