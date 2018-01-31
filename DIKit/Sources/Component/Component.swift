//
//  Component.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public final class Component<T>: ComponentProtocol {
    public let scope: Scope
    public let type: Any.Type
    public let weakFactory: WeakFactory
    
    init(scope: Scope, type: T.Type, factory: @escaping () throws -> T) {
        self.scope = scope
        self.type = type
        self.weakFactory = { try factory() }
    }
}

public protocol ComponentProtocol {
    var weakFactory: WeakFactory { get }
    var type: Any.Type { get }
}
