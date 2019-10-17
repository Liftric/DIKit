// DIKitTests.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
// swiftlint:disable nesting
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

        guard let componentA = dependencyContainer.componentStack.index(forKey: "ComponentA") else {
            return XCTFail()
        }
        let componentProtocolA = dependencyContainer.componentStack[componentA].value
        XCTAssertEqual(componentProtocolA.lifetime, .singleton)
        let instanceA = componentProtocolA.componentFactory()
        XCTAssertTrue(instanceA is ComponentA)
        XCTAssertFalse(instanceA is ComponentB)

        guard let componentB = dependencyContainer.componentStack.index(forKey: "ComponentB") else {
            return XCTFail()
        }
        let componentProtocolB = dependencyContainer.componentStack[componentB].value
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

        let dependencyContainer = DependencyContainer.derive(from: dependencyContainerA,
                                                             dependencyContainerB,
                                                             dependencyContainerC)

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)

        let componentB: ComponentB = dependencyContainer.resolve()
        XCTAssertNotNil(componentB)

        let componentC: ComponentC = dependencyContainer.resolve()
        XCTAssertNotNil(componentC)
    }

    func testDependencyContainerDeriveDSL() {
        struct ComponentA {}
        struct ComponentB {}
        struct ComponentC {}

        let dependencyContainerA = module {
            single { ComponentA() }
        }
        let dependencyContainerB = module {
            single { ComponentB() }
        }
        let dependencyContainerC = module {
            single { ComponentC() }
        }

        let dependencyContainer = modules { dependencyContainerA; dependencyContainerB; dependencyContainerC }

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)

        let componentB: ComponentB = dependencyContainer.resolve()
        XCTAssertNotNil(componentB)

        let componentC: ComponentC = dependencyContainer.resolve()
        XCTAssertNotNil(componentC)
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

    func testLazyInjection() {
        struct TestStateHolder {
            static var initializedA = false
            static var initializedB = false
        }
        class ComponentA {
            init() {
                TestStateHolder.initializedA = true
            }
        }
        class ComponentB {
            init() {
                TestStateHolder.initializedB = true
            }
        }
        class TestApplication: DefinesContainer {
            let container = module {
                single { ComponentA() }
                factory { ComponentB() }
            }
        }

        DependencyContainer.defined(by: TestApplication())

        class TestViewController {
            @Inject var componentA: ComponentA
            @Inject(.lazy) var componentB: ComponentB
        }

        let testVC = TestViewController()
        XCTAssertTrue(TestStateHolder.initializedA)
        _ = testVC.componentA
        XCTAssertTrue(TestStateHolder.initializedA)

        XCTAssertFalse(TestStateHolder.initializedB)
        _ = testVC.componentB
        XCTAssertTrue(TestStateHolder.initializedB)
    }

    func testFactoryOfComponentsDSL() {
        class ComponentA {}

        let dependencyContainer = module {
            factory { ComponentA() }
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
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
    }

    func testSingletonLifetimeOfComponentsDSL() {
        class ComponentA {}

        let dependencyContainer = module {
            single { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)

        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
    }
}
