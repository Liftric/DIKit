// Scope.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


/// Defines the `Component` scope.
public enum Scope {
    /// The same instance of the class is returned each time it is injected.
    case singleton

    /// A new instance of the class is created each time it is injected.
    case prototype
}
