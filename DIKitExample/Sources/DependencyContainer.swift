// DependencyContainer.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import DIKit

public extension DependencyContainer {
    static var storage: DependencyContainer {
        return DependencyContainer { container in
            container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
        }
    }
}

public extension DependencyContainer {
    static var network: DependencyContainer {
        return DependencyContainer { container in
            container.register(as: .singleton) { Network() as NetworkProtocol }
        }
    }
}
