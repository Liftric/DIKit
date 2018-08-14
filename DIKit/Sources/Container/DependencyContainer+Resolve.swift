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
        let tag = String(describing: T.self)
        guard let foundComponent = self.componentStack[tag] else {
            fatalError("Component could not be resolved.")
        }
        if foundComponent.scope == .prototype {
            return foundComponent.componentFactory() as! T
        }
        if let instanceOfComponent = self.instanceStack[tag] as? T {
            return instanceOfComponent
        }
        let instance = foundComponent.componentFactory() as! T
        self.instanceStack[tag] = instance
        return instance
    }
}
