//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public final class DependencyContainer {
    var bootstrapped = false
    var componentStack = [String: ComponentProtocol]()
    var instanceStack = [String: Any]()
    let lock = NSRecursiveLock()
    
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    public init(boostrapBlock: BootstrapBlock) {
        threadSafe {
            boostrapBlock(self)
            self.bootstrapped = true
        }
    }
    
    func threadSafe(_ closure: () -> ()) -> () {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
}
