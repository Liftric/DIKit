// ContainerContext.swift
//
// - Authors:
// Ben John
//
// - Date: 21.10.19
//
// Copyright © 2019 Ben John. All rights reserved.

/// Exposes the `DependencyContainer` through for instance `AppDelegate`.
public protocol ContainerContext {
    var container: DependencyContainer { get }
}
