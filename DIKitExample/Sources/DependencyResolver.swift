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
import DIKit

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
