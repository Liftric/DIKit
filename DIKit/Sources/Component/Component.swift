// Component.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.

public typealias ComponentFactory = () -> Any

class Component<T>: ComponentProtocol {
    let lifetime: Lifetime
    let tag: String
    let type: Any.Type
    let componentFactory: ComponentFactory

    init(lifetime: Lifetime, type: T.Type, factory: @escaping () -> T) {
        self.lifetime = lifetime
        self.tag = String(describing: type)
        self.type = type
        self.componentFactory = { factory() }
    }
}

public protocol ComponentProtocol {
    var lifetime: Lifetime { get }
    var tag: String { get }
    var componentFactory: ComponentFactory { get }
    var type: Any.Type { get }
}
