//
//  Resolver.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

public final class DependencyContainer {
    public typealias BootstrapBlock = (DependencyContainer) -> Void
    public init(boostrapBlock: BootstrapBlock = { _ in }) {
        boostrapBlock(self)
    }
    
    var componentStack = [ComponentProtocol]()
}
