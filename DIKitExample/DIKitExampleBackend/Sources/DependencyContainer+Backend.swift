// DependencyContainer+Backend.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import DIKit

public extension DependencyContainer {
    static var backend: DependencyContainer {
        return DependencyContainer { container in
            container.register { Backend() as BackendProtocol }
            container.register { Network() as NetworkProtocol }
        }
    }
}
