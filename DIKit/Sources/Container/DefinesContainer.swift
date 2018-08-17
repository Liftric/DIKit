// DefinesContainer.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


/// Exposes the `DependencyContainer` through `AppDelegate`.
public protocol DefinesContainer {
    var container: DependencyContainer { get }
}
