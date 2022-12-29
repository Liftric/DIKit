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
    static var app = module {
        // We create two different kind of storages. One for both kind of contexts.
        factory(tag: StorageContext.systemdata) { LocalStorage(name: "system") as LocalStorageProtocol }
        factory(tag: StorageContext.userdata) { LocalStorage(name: "userdata") as LocalStorageProtocol }

        factory { LocalStorage(name: "default") as LocalStorageProtocol }
        factory { name in LocalStorage(name: name) as LocalStorageProtocol }
        factory { (args: (name: String, other: Int)) in LocalStorage(name: args.name) as LocalStorageProtocol }
    }
}
