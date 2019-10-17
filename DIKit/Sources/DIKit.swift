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
public func resolve<T>() -> T {
    DependencyContainer.shared.container.resolve()
}

/// Injects a generic method to resolve given `Component<T>`.
public func get<T>() -> (() -> T) { { resolve() } }

/// A property wrapper (SE-0258) to make a `Component` easily injectable
/// through `@Inject var variableName: Component`.
@propertyWrapper
public enum Inject<Component> {
    case unresolved(() -> Component)
    case resolved(Component)

    public enum Relationship {
        case direct
        case lazy
    }

    /// To overcome compiler errors.
    public init() {
        self = .resolved(resolve())
    }

    public init(_ relationship: Relationship = .direct) {
        if relationship == .lazy {
            self = .unresolved({ resolve() })
        } else {
            self = .resolved(resolve())
        }
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
