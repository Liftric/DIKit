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
    DependencyContainer.defines.container.resolve()
}

/// Injects a generic method to resolve given `Component<T>`.
public func get<T>() -> (() -> T) {
    {
        resolve()
    }
}

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

    public init(relationship: Relationship = .direct) {
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

@_functionBuilder
public struct ModuleBuilder {
    public static func buildBlock(_ children: [ComponentProtocol]...) -> [ComponentProtocol] {
        return children.flatMap {
            $0
        }
    }

    public static func buildBlock(_ component: [ComponentProtocol]) -> [ComponentProtocol] {
        return component
    }
}

public func module(@ModuleBuilder makeChildren: () -> [ComponentProtocol]) -> DependencyContainer {
    return DependencyContainer { container in
        for c in makeChildren() {
            container.register(c)
        }
    }
}

@_functionBuilder
public struct ModulesBuilder {
    public static func buildBlock(_ children: DependencyContainer...) -> [DependencyContainer] {
        return children.compactMap {
            $0
        }
    }

    public static func buildBlock(_ component: DependencyContainer) -> [DependencyContainer] {
        return [component]
    }
}

public func modules(@ModulesBuilder makeChildren: () -> [DependencyContainer]) -> DependencyContainer {
    return DependencyContainer.derive(from: makeChildren())
}

public func resolvable<T>(lifetime: Lifetime = .singleton, _ factory: @escaping () -> T) -> ComponentProtocol {
    let component = Component(lifetime: lifetime, type: T.self, factory: factory)
    return component as ComponentProtocol
}

public func factory<T>(factory: @escaping () -> T) -> [ComponentProtocol] {
    return [resolvable(lifetime: .factory, factory)]
}

public func single<T>(factory: @escaping () -> T) -> [ComponentProtocol] {
    return [resolvable(lifetime: .singleton, factory)]
}
