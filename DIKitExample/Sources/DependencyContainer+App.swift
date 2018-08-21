// DependencyContainer+App.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import DIKit

public extension DependencyContainer {
    static var app: DependencyContainer {
        return DependencyContainer { container in
            container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
        }
    }
}
