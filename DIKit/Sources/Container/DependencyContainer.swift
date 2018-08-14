//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public final class DependencyContainer {
    internal var bootstrapped = false
    internal var componentStack = [String: ComponentProtocol]()
    internal var instanceStack = [String: Any]()
    internal let lock = NSRecursiveLock()

    public typealias BootstrapBlock = (DependencyContainer) -> Void
    public init(boostrapBlock: BootstrapBlock) {
        threadSafe {
            boostrapBlock(self)
            self.bootstrapped = true
        }
    }

    internal func threadSafe(_ closure: () -> ()) -> () {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
}
