// DIKit.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

/// Resolves given `Component<T>`.
///
/// - Returns: The resolved `Component<T>`.
public func resolve<T>() -> T { DependencyContainer.shared.resolve() }

/// Resolves nil safe given `Component<T>`.
///
/// - Returns: The resolved `Optional<Component<T>>`.
public func resolveOptional<T>() -> T? {
    guard DependencyContainer.shared.resolvable(type: T.self) else { return nil }
    return DependencyContainer.shared._resolve()
}
