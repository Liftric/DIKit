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

    func testDependencyContainerScope() {
        struct ComponentA {}
        struct ComponentB {}

        let dependencyContainer = DependencyContainer(scope: "session") { (c: DependencyContainer) in
            c.register { ComponentA() }
            c.register { ComponentB() }
        }

        guard let mainComponentStackA: [String: ComponentProtocol] = dependencyContainer.componentStack["session"] else {
            return XCTFail()
        }
        guard let componentA = mainComponentStackA.index(forKey: "ComponentA") else {
            return XCTFail()
        }
        let componentProtocolA = mainComponentStackA[componentA].value
        XCTAssertEqual(componentProtocolA.lifetime, .singleton)
        let instanceA = componentProtocolA.componentFactory()
        XCTAssertTrue(instanceA is ComponentA)
        XCTAssertFalse(instanceA is ComponentB)

        guard let mainComponentStackB = dependencyContainer.componentStack["session"] else {
            return XCTFail()
        }
        guard let componentB = mainComponentStackB.index(forKey: "ComponentB") else {
            return XCTFail()
        }
        let componentProtocolB = mainComponentStackB[componentB].value
        XCTAssertEqual(componentProtocolB.lifetime, .singleton)
        let instanceB = componentProtocolB.componentFactory()
        XCTAssertTrue(instanceB is ComponentB)
        XCTAssertFalse(instanceB is ComponentA)

        XCTAssertNil(dependencyContainer.componentStack[""])
    }

    func testDependencyContainerCreation() {
        struct ComponentA {}
        struct ComponentB {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentA() }
            c.register { ComponentB() }
        }

        guard let mainComponentStackA: [String: ComponentProtocol] = dependencyContainer.componentStack[""] else {
            return XCTFail()
        }
        guard let componentA = mainComponentStackA.index(forKey: "ComponentA") else {
            return XCTFail()
        }
        let componentProtocolA = mainComponentStackA[componentA].value
        XCTAssertEqual(componentProtocolA.lifetime, .singleton)
        let instanceA = componentProtocolA.componentFactory()
        XCTAssertTrue(instanceA is ComponentA)
        XCTAssertFalse(instanceA is ComponentB)

        guard let mainComponentStackB = dependencyContainer.componentStack[""] else {
            return XCTFail()
        }
        guard let componentB = mainComponentStackB.index(forKey: "ComponentB") else {
            return XCTFail()
        }
        let componentProtocolB = mainComponentStackB[componentB].value
        XCTAssertEqual(componentProtocolB.lifetime, .singleton)
        let instanceB = componentProtocolB.componentFactory()
        XCTAssertTrue(instanceB is ComponentB)
        XCTAssertFalse(instanceB is ComponentA)
    }

    func testDependencyContainerResolve() {
        struct ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentA() }
        }

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)
    }

    func testDependencyContainerDerive() {
        struct ComponentA {}
        struct ComponentB {}
        struct ComponentC {}

        let dependencyContainerA = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentA() }
        }
        let dependencyContainerB = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentB() }
        }
        let dependencyContainerC = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentC() }
        }

        let dependencyContainer = DependencyContainer.derive(from: dependencyContainerA, dependencyContainerB, dependencyContainerC)

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)

        let componentB: ComponentB = dependencyContainer.resolve()
        XCTAssertNotNil(componentB)

        let componentC: ComponentC = dependencyContainer.resolve()
        XCTAssertNotNil(componentC)
    }

    func testTransientLifetimeOfComponents() {
        class ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register(lifetime: .transient) { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier.init(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier.init(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier.init(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertNotEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
    }

    func testSingletonLifetimeOfComponents() {
        class ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register(lifetime: .singleton) { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier.init(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier.init(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier.init(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
    }
}
