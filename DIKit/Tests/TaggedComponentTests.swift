// TaggedComponentTests.swift
//
// - Authors:
// Ben John
//
// - Date: 27.08.20
// Copyright © 2020 Ben John. All rights reserved.

import XCTest
@testable import DIKit

class TaggedComponentTests: XCTestCase {
    func testDependencyContainerTaggedResolve() {
        class ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register(tag: "tag") { ComponentA() }
        }

        let componentA: ComponentA = dependencyContainer.resolve(tag: "tag")
        XCTAssertNotNil(componentA)
    }
}
