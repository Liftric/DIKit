// HasContainerContext.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

public protocol HasResolverContext {
    static func resolver<T>() -> T
}

public extension HasResolverContext {
    static func resolver<T>() -> T {
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DefinesResolver else {
            fatalError("The main application delegate needs to conform `DefinesResolver`.")
        }
        return sharedDelegateCasted.resolver()
    }
}
