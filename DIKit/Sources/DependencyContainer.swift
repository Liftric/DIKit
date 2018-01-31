//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public typealias WeakFactory = (() throws -> Any)!

public final class DependencyContainer {
    // Constructor
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    public init(boostrapBlock: BootstrapBlock = { _ in }) {
        boostrapBlock(self)
    }
    
    var componentStack = [ComponentProtocol]()
}

extension DependencyContainer {
    public func register<T>(scope: Scope = .prototype, type: T.Type = T.self, _ factory: @escaping () throws -> T) {
        let component = Component(scope: scope, type: type, factory: factory)
        self.componentStack.append(component as ComponentProtocol)
    }
}

public class ResolveError: Error {
    
}

extension DependencyContainer {
    public func resolve<T>() throws -> T {
        guard let index = self.componentStack.index(where: { $0.type == T.self }) else {
            throw ResolveError()
        }
        let foundComponent = self.componentStack[index]
        return try! foundComponent.weakFactory() as! T
    }
}
