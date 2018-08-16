// SecondViewController.generated.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation
import DIKit

extension SecondViewController {
    var dependency: Dependency {
        return DependencyGenerated()
    }
    
    private class DependencyGenerated: Dependency, HasContainerContext {
        lazy var localStorage: LocalStorageProtocol = {
            return container.resolve()
        }()
    }
}
