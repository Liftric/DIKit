// DIKit+Inject.swift
//
// - Authors:
// Ben John
//
// - Date: 20.10.2019
//
// Copyright © 2019 Ben John. All rights reserved.

/// A property wrapper (SE-0258) to make a `Component` lazily injectable
/// through `@LazyInject var variableName: Component`.
public enum LazyInject<Component> {
    case unresolved(() -> Component)
    case resolved(Component)

    public init() {
        self = .unresolved(resolveFunc())
    }

    public var wrappedValue: Component {
        mutating get {
            switch self {
            case .unresolved(let resolver):
                let component = resolver()
                self = .resolved(component)
                return component
            case .resolved(let component):
                return component
            }
        }
    }
}

/// A property wrapper (SE-0258) to make a `Component` eagerly injectable
/// through `@Inject var variableName: Component`.
@propertyWrapper
public struct Inject<Component> {
    public init() {}

    public var wrappedValue: Component {
        resolve()
    }
}
