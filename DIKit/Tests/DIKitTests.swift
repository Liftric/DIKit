// DIKitTests.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import XCTest
@testable import DIKit

class DIKitTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDependencyContainerCreation() {
        struct ComponentA {}
        struct ComponentB {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentA() }
            c.register { ComponentB() }
        }

        let componentA = dependencyContainer.componentStack.index(forKey: "ComponentA")
        XCTAssertNotNil(componentA)

        let componentB = dependencyContainer.componentStack.index(forKey: "ComponentA")
        XCTAssertNotNil(componentB)
    }
}
