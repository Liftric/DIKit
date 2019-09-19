// DIKit.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

#if canImport(UIKit)
import UIKit
#endif

extension DependencyContainer {
    static var shared: DependencyContainer {
        #if os(iOS)
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DefinesContainer else {
            fatalError("The main application delegate needs to conform `DefinesContainer`.")
        }
        return sharedDelegateCasted.container
        #else
        fatalError("DIKit currently only runs on iOS.")
        #endif
    }
}

/// Injects lazily given `Component<T>`.
///
/// - Returns: The resolved `Component<T>`.
public func inject<T>() -> T {
    return DependencyContainer.shared.resolve()
}

/// Injects lazily a generic method to resolve given `Component<T>`.
public func get<T>() -> (() ->T) {
    return {
        return DependencyContainer.shared.resolve()
    }
}

/// A property wrapper (SE-0258) to make a `Component` easily injectable
/// through `@Injectable var variableName: Component`.
@propertyWrapper
public struct Injectable<Component> {
    public init() {}
    
    public var wrappedValue: Component {
        get {
            return DependencyContainer.shared.resolve()
        }
    }
}

@_functionBuilder
public struct ModuleBuilder {
    public static func buildBlock(_ children: [ComponentProtocol]...) -> [ComponentProtocol] {
        return children.flatMap { $0 }
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
        return children.compactMap { $0 }
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
