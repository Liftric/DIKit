// DependencyResolver.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import UIKit

protocol HasResolverContext {
    static var resolver: DependencyResolver { get }
}

extension HasResolverContext {
    static var resolver: DependencyResolver {
        guard let sharedDelegateCasted = UIApplication.shared.delegate as? DefinesResolver else {
            fatalError("The main application delegate needs to conform `DefinesResolver`.")
        }
        return sharedDelegateCasted.resolver
    }
}

protocol DefinesResolver {
    var resolver: DependencyResolver { get }
}

protocol DependencyResolver {
    var network: NetworkProtocol { get }
    var backend: BackendProtocol { get }
    var localStorage: LocalStorageProtocol { get }
}

class DependencyResolverImpl: DependencyResolver {
    lazy var network: NetworkProtocol = {
        return Network()
    }()
    lazy var backend: BackendProtocol = {
        return Backend(network: network)
    }()
    var localStorage: LocalStorageProtocol {
        return LocalStorage()
    }
}
