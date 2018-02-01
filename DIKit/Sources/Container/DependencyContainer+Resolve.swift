//
//  DependencyContainer+Resolve.swift
//  DIKit
//
//  Created by Ben John on 01.02.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

extension DependencyContainer {
    public func resolve<T>() -> T {
        guard let index = self.componentStack.index(where: { $0.type == T.self }) else {
            fatalError()
        }
        let foundComponent = self.componentStack[index]
        if foundComponent.scope == .singleton {
            if let index = self.instanceStack.index(where: { $0 is T }) {
                return self.instanceStack[index] as! T
            } else {
                let instance = foundComponent.weakFactory() as! T
                self.instanceStack.append(instance)
                return instance
            }
        }
        return foundComponent.weakFactory() as! T
    }
}

