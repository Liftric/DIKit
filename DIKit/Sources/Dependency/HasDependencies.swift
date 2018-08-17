// HasDependencies.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

public protocol HasDependencies {
    associatedtype Dependency
    var dependency: Dependency! { get }
}
