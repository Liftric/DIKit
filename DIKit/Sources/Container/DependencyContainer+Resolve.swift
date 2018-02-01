//
//  DependencyContainer+Resolve.swift
//  DIKit
//
//  Created by Ben John on 01.02.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

extension DependencyContainer {
    public func resolve<T>() throws -> T {
        guard let index = self.componentStack.index(where: { $0.type == T.self }) else {
            throw ResolveError()
        }

        let foundComponent = self.componentStack[index]
        return try! foundComponent.weakFactory() as! T
    }
}
