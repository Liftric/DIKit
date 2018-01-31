//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation
public final class DependencyContainer {
    // Constructor
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    public init(boostrapBlock: BootstrapBlock = { _ in }) {
        boostrapBlock(self)
    }

    // Simple Dependency Stack
    var stack = [WeakFactory]()
}

extension DependencyContainer {
    // TODO need to move this to another class for having a generic factory holder
     public func register<T, F>(scope: Component.Scope = .prototype, _ factory: @escaping (F) throws -> T) {
        self.stack.append(Component.Factory(factory: factory) as WeakFactory)
    }
}

extension DependencyContainer {
    public func resolve<T>() throws -> T {
        return try self.stack[0].weakFactory(T.self) as! T
    }
}
