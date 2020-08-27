// DependencyContainerTests.swift
//
// - Authors:
// Ben John
//
// - Date: 27.08.20
// swiftlint:disable nesting
// Copyright © 2020 Ben John. All rights reserved.

import XCTest
@testable import DIKit

class DependencyContainerTests: XCTestCase {
    func testDependencyContainerCreation() {
        struct ComponentA {}
        struct ComponentB {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register { ComponentA() }
            c.register { ComponentB() }
            c.register(tag: "tag") { ComponentB() }
        }

        let componentAIdentifier = ComponentIdentifier(type: ComponentA.self)
        guard let componentA = dependencyContainer.componentStack.index(forKey: componentAIdentifier) else {
            return XCTFail("ComponentStack does not contain `ComponentA`.")
        }
        let componentProtocolA = dependencyContainer.componentStack[componentA].value
        XCTAssertEqual(componentProtocolA.lifetime, .singleton)
        let instanceA = componentProtocolA.componentFactory()
        XCTAssertTrue(instanceA is ComponentA)
        XCTAssertFalse(instanceA is ComponentB)

        let componentBIdentifier = ComponentIdentifier(type: ComponentB.self)
        guard let componentB = dependencyContainer.componentStack.index(forKey: componentBIdentifier) else {
            return XCTFail("ComponentStack does not contain `ComponentB`.")
        }
        let componentProtocolB = dependencyContainer.componentStack[componentB].value
        XCTAssertEqual(componentProtocolB.lifetime, .singleton)
        let instanceB = componentProtocolB.componentFactory()
        XCTAssertTrue(instanceB is ComponentB)
        XCTAssertFalse(instanceB is ComponentA)

        let taggedComponentBIdentifier = ComponentIdentifier(tag: "tag", type: ComponentB.self)
        guard let taggedComponentB = dependencyContainer.componentStack.index(forKey: taggedComponentBIdentifier) else {
            return XCTFail("ComponentStack does not contain `ComponentB`.")
        }
        let taggedComponentProtocolB = dependencyContainer.componentStack[taggedComponentB].value
        XCTAssertEqual(taggedComponentProtocolB.lifetime, .singleton)
        let taggedInstanceB = taggedComponentProtocolB.componentFactory()
        XCTAssertTrue(taggedInstanceB is ComponentB)
        XCTAssertFalse(taggedInstanceB is ComponentA)
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
        let dependencyContainerD = DependencyContainer { (c: DependencyContainer) in
            c.register(tag: "tag") { ComponentC() }
        }

        let dependencyContainer = DependencyContainer.derive(from: dependencyContainerA,
                                                             dependencyContainerB,
                                                             dependencyContainerC,
                                                             dependencyContainerD)

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)

        let componentB: ComponentB = dependencyContainer.resolve()
        XCTAssertNotNil(componentB)

        let componentC: ComponentC = dependencyContainer.resolve()
        XCTAssertNotNil(componentC)

        let taggedComponentC: ComponentC = dependencyContainer.resolve(tag: "tag")
        XCTAssertNotNil(taggedComponentC)
    }

    func testFactoryOfComponents() {
        class ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register(lifetime: .factory) { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertNotEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
    }

    func testSingletonLifetimeOfComponents() {
        class ComponentA {}

        let dependencyContainer = DependencyContainer { (c: DependencyContainer) in
            c.register(lifetime: .singleton) { ComponentA() }
            c.register(lifetime: .singleton, tag: "tag") { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let taggedComponentAinstanceA: ComponentA = dependencyContainer.resolve(tag: "tag")
        XCTAssertNotNil(taggedComponentAinstanceA)

        let taggedComponentAinstanceB: ComponentA = dependencyContainer.resolve(tag: "tag")
        XCTAssertNotNil(taggedComponentAinstanceB)

        XCTAssertTrue(componentAinstanceA === componentAinstanceB)
        XCTAssertTrue(taggedComponentAinstanceA === taggedComponentAinstanceB)
        XCTAssertTrue(componentAinstanceA !== taggedComponentAinstanceA)
        XCTAssertTrue(componentAinstanceA !== taggedComponentAinstanceB)
    }
}
