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
    static var backend = module {
        single { Backend() as BackendProtocol }
        single { Network() as NetworkProtocol }
    }
}
