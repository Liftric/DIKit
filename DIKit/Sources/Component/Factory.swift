//
//  Factory.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

extension Component {
    public final class Factory<T, F>: WeakFactory {
        public typealias ComponentFactory = (F) throws -> T
        public var factory: ComponentFactory
        public var weakFactory: ((Any) throws -> Any)!

        init(factory: @escaping ComponentFactory) {
            self.factory = factory
            self.weakFactory = { try factory($0 as! F) }
        }
    }
}

public protocol WeakFactory {
    var weakFactory: ((Any) throws -> Any)! { get }
}
