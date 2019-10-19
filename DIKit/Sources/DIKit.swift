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
public func resolveFunc<T>() -> (() -> T) { { resolve() } }

public enum Instance<Component> {
    case unresolved(() -> Component)
    case resolved(Component)
    
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

/// A property wrapper (SE-0258) to make a `Component` easily injectable
/// through `@Inject var variableName: Component`.
@propertyWrapper
public class Inject<Component> {
    public enum Fetch {
        case eager
        case lazy
    }
    
    private var instance: Instance<Component>
    
    /// To overcome compiler errors.
    public init() {
        self.instance = .resolved(resolve())
    }
    
    public init(_ fetch: Fetch = .eager) {
        if fetch == .lazy {
            self.instance = .unresolved(resolveFunc())
        } else {
            self.instance = .resolved(resolve())
        }
    }
    
    public var wrappedValue: Component {
        return self.instance.wrappedValue
    }
}
