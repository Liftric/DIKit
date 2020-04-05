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
@propertyWrapper
public enum LazyInject<Component> {
    case unresolved(() -> Component)
    case resolved(Component)

    public init() {
        self = .unresolved({ resolve() })
    }

    public init(tag: AnyHashable? = nil) {
        self = .unresolved({ resolve(tag: tag) })
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
    public let wrappedValue: Component

    public init() {
        self.wrappedValue = resolve()
    }

    public init(tag: AnyHashable? = nil) {
        self.wrappedValue = resolve(tag: tag)
    }
}

/// A property wrapper (SE-0258) to make a `Optional<Component>` injectable
/// through `@OptionalInject var variableName: Component?`. Lazy by default.
@propertyWrapper
public enum OptionalInject<Component> {
    case unresolved(() -> Component?)
    case resolved(Component?)

    public init() {
        self = .unresolved({ resolveOptional() })
    }

    public init(tag: AnyHashable? = nil) {
        self = .unresolved({ resolveOptional(tag: tag) })
    }

    public var wrappedValue: Component? {
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
