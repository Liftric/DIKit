// LazyInjectTests.swift
//
// - Authors:
// Ben John
//
// - Date: 27.08.20
// Copyright © 2020 Ben John. All rights reserved.

import XCTest
@testable import DIKit

class LazyInjectTests: XCTestCase {
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
}
