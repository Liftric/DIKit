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
    let identifier: AnyHashable
    let type: Any.Type
    let componentFactory: ComponentFactory

    init(lifetime: Lifetime, factory: @escaping () -> T) {
        self.lifetime = lifetime
        self.identifier = ComponentIdentifier(type: T.self)
        self.type = T.self
        self.componentFactory = { factory() }
    }

    init(lifetime: Lifetime, tag: AnyHashable, factory: @escaping () -> T) {
        self.lifetime = lifetime
        self.identifier = ComponentIdentifier(tag: tag, type: T.self)
        self.type = T.self
        self.componentFactory = { factory() }
    }
}

struct ComponentIdentifier: Hashable {
    let tag: AnyHashable?
    let type: Any.Type

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type))
        if let tag = tag {
            hasher.combine(tag)
        }
    }

    static func == (lhs: ComponentIdentifier, rhs: ComponentIdentifier) -> Bool {
        lhs.type == rhs.type && lhs.tag == rhs.tag
    }
}

extension ComponentIdentifier {
    init(type: Any.Type) {
        self.type = type
        self.tag = nil
    }
}

public protocol ComponentProtocol {
    var lifetime: Lifetime { get }
    var identifier: AnyHashable { get }
    var componentFactory: ComponentFactory { get }
    var type: Any.Type { get }
}
