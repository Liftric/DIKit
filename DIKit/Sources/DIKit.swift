// DIKit.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

public protocol DIKitProtocol {
    var container: DependencyContainer { get }
}

public class DIKit {
    /// Shortcut for using `DIKit.shared.container.inject`.
    public class func inject(into object: AnyObject) {
        DIKit.shared.container.inject(into: object)
    }

    /// Shortcut for using `DIKit.shared.container.resolve`.
    public class func resolve<T>() -> T {
        return DIKit.shared.container.resolve()
    }

    private class var shared: DIKitProtocol {
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DIKitProtocol else {
            fatalError("The main application delegate needs to conform `DIKitProtocol`.")
        }
        return sharedDelegateCasted
    }
}
