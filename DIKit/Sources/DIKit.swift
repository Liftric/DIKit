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
/// - Parameter tag: An optional *tag* to identify the Component. `nil` per default.
/// - Returns: The resolved `Component<T>`.
public func resolve<T>(tag: AnyHashable? = nil) -> T { DependencyContainer.shared.resolve(tag: tag) }

/// Resolves nil safe given `Component<T>`.
///
/// - Parameter tag: An optional *tag* to identify the Component. `nil` per default.
/// - Returns: The resolved `Optional<Component<T>>`.
public func resolveOptional<T>(tag: AnyHashable? = nil) -> T? {
    guard DependencyContainer.shared.resolvable(type: T.self, tag: tag) else { return nil }
    return DependencyContainer.shared._resolve(tag: tag)
}
