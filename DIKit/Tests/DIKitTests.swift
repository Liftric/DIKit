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
            return XCTFail("ComponentStack does not contain `ComponentA`.")
        }
        let componentProtocolA = dependencyContainer.componentStack[componentA].value
        XCTAssertEqual(componentProtocolA.lifetime, .singleton)
        let instanceA = componentProtocolA.componentFactory()
        XCTAssertTrue(instanceA is ComponentA)
        XCTAssertFalse(instanceA is ComponentB)

        guard let componentB = dependencyContainer.componentStack.index(forKey: "ComponentB") else {
            return XCTFail("ComponentStack does not contain `ComponentB`.")
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

    func testOptionalFactory() {
        struct TestStateHolder {
            static var initialized = [String]()
            static func isInitialized(_ object: Any) -> Bool { initialized.contains(String(describing: object)) }
        }

        TestStateHolder.initialized.removeAll()

        class ComponentE {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }
        class ComponentF {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }

        DependencyContainer.root = nil
        DependencyContainer.defined(by: module {
            factory { ComponentE() }
            single { ComponentF() }
        })

        class Test1ViewController {
            @OptionalInject var componentE: ComponentE?
            @OptionalInject var componentF: ComponentF?
        }

        class Test2ViewController {
            @OptionalInject var componentE: ComponentE?
            @OptionalInject var componentF: ComponentF?
        }

        let test1VC = Test1ViewController()
        let test2VC = Test2ViewController()

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentE.self))
        XCTAssertNotNil(test1VC.componentE)
        _ = test1VC.componentE
        XCTAssertNotNil(test1VC.componentE)
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentE.self))

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentF.self))
        XCTAssertNotNil(test1VC.componentF)
        _ = test1VC.componentF
        XCTAssertNotNil(test1VC.componentF)
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentF.self))

        TestStateHolder.initialized.removeAll()

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentE.self))
        XCTAssertNotNil(test2VC.componentE)
        _ = test2VC.componentE
        XCTAssertNotNil(test2VC.componentE)
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentE.self))

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentF.self))
        XCTAssertNotNil(test2VC.componentF)
        _ = test2VC.componentF
        XCTAssertNotNil(test2VC.componentF)
        XCTAssertFalse(TestStateHolder.isInitialized(ComponentF.self))

        XCTAssertNotEqual(
                ObjectIdentifier(test1VC.componentE!),
                ObjectIdentifier(test2VC.componentE!)
        )

        XCTAssertEqual(
                ObjectIdentifier(test1VC.componentF!),
                ObjectIdentifier(test2VC.componentF!)
        )
    }

    func testOptionalInjection() {
        struct TestStateHolder {
            static var initialized = [String]()
            static func isInitialized(_ object: Any) -> Bool { initialized.contains(String(describing: object)) }
        }

        TestStateHolder.initialized.removeAll()

        class ComponentE {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }
        class ComponentF {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }

        DependencyContainer.root = nil
        DependencyContainer.defined(by: module {
            single { ComponentF() }
        })

        class TestViewController {
            @OptionalInject var componentE: ComponentE?
            @OptionalInject var componentF: ComponentF?
        }

        let testVC = TestViewController()

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentE.self))
        XCTAssertNil(testVC.componentE)
        _ = testVC.componentE
        XCTAssertNil(testVC.componentE)
        XCTAssertFalse(TestStateHolder.isInitialized(ComponentE.self))

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentF.self))
        XCTAssertNotNil(testVC.componentF)
        _ = testVC.componentF
        XCTAssertNotNil(testVC.componentF)
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentF.self))
    }

    func testLazyInjection() {
        struct TestStateHolder {
            static var initialized = [String]()
            static func isInitialized(_ object: Any) -> Bool { initialized.contains(String(describing: object)) }
        }

        TestStateHolder.initialized.removeAll()

        class ComponentA {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }
        class ComponentB {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }
        class ComponentC {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }
        class ComponentD {
            init() { TestStateHolder.initialized.append(String(describing: Self.self)) }
        }

        DependencyContainer.root = nil
        DependencyContainer.defined(by: module {
            single { ComponentA() }
            factory { ComponentB() }
            single { ComponentC() }
            factory { ComponentD() }
        })

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentD.self))

        class TestViewController {
            @Inject var componentA: ComponentA
            @LazyInject var componentB: ComponentB
            @LazyInject var componentC: ComponentC
            @Inject var componentD: ComponentD
        }

        let test1VC = TestViewController()
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentA.self))
        _ = test1VC.componentA
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentA.self))

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentB.self))
        _ = test1VC.componentB
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentB.self))

        XCTAssertFalse(TestStateHolder.isInitialized(ComponentC.self))
        _ = test1VC.componentC
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentC.self))

        XCTAssertTrue(TestStateHolder.isInitialized(ComponentD.self))
        _ = test1VC.componentD
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentD.self))

        TestStateHolder.initialized.removeAll()

        class Test2ViewController {
            @LazyInject var componentC: ComponentC
            @Inject var componentD: ComponentD
        }

        let test2VC = Test2ViewController()
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentD.self))
        _ = test2VC.componentD
        XCTAssertTrue(TestStateHolder.isInitialized(ComponentD.self))

        XCTAssertNotEqual(
                ObjectIdentifier(test1VC.componentD),
                ObjectIdentifier(test2VC.componentD)
        )

        XCTAssertEqual(
                ObjectIdentifier(test1VC.componentC),
                ObjectIdentifier(test2VC.componentC)
        )
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
