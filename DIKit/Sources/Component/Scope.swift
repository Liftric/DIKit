//
//  Scope.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

/// Defines the `Component` scope.
public enum Scope {
    /// A new instance of the class is created each time it is injected.
    case prototype

    /// The same instance of the class is returned each time it is injected.
    case singleton
}
