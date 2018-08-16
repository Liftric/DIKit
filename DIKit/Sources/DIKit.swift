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
    public class var shared: DIKitProtocol {
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DIKitProtocol else {
            fatalError("The main application delegate needs to conform `DIKitProtocol`.")
        }
        return sharedDelegateCasted
    }
}
