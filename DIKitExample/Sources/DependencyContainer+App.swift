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
        factory(tag: StorageContext.systemdata) { LocalStorage() as LocalStorageProtocol }
        factory(tag: StorageContext.userdata) { LocalStorage() as LocalStorageProtocol }
    }
}
