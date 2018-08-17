// Component.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


typealias ComponentFactory = () -> Any

class Component<T>: ComponentProtocol {
    let scope: Scope
    let tag: String
    let type: Any.Type
    let componentFactory: ComponentFactory

    init(scope: Scope, type: T.Type, factory: @escaping () -> T) {
        self.scope = scope
        self.tag = String(describing: type)
        self.type = type
        self.componentFactory = { factory() }
    }
}

protocol ComponentProtocol {
    var scope: Scope { get }
    var componentFactory: ComponentFactory { get }
    var type: Any.Type { get }
}
