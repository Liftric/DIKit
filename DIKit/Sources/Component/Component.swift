//
//  Component.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public typealias ComponentFactory = () -> Any

public final class Component<T>: ComponentProtocol {
    public let scope: Scope
    public let tag: String
    public let type: Any.Type
    public let componentFactory: ComponentFactory

    init(scope: Scope, type: T.Type, factory: @escaping () -> T) {
        self.scope = scope
        self.tag = String(describing: type)
        self.type = type
        self.componentFactory = { factory() }
    }
}

public protocol ComponentProtocol {
    var scope: Scope { get }
    var componentFactory: ComponentFactory { get }
    var type: Any.Type { get }
}

