// DIKit.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


extension DependencyContainer {
    static var shared: DependencyContainer {
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DefinesContainer else {
            fatalError("The main application delegate needs to conform `DefinesContainer`.")
        }
        return sharedDelegateCasted.container
    }
}

/// Injects lazily given `Component<T>`.
///
/// - Returns: The resolved `Component<T>`.
public func inject<T>() -> T {
    return DependencyContainer.shared.resolve()
}
