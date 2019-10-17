// Lifetime.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

/// Defines the `Component` lifetime.
public enum Lifetime {
    /// The same instance of the class is returned each time it is injected.
    /// The `Component` has its lifetime connected to the container instance.
    case singleton

    /// A new instance of the class is created each time it is injected. The
    /// container holds no reference to it.
    case factory
}
