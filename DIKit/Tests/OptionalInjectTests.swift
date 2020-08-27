// OptionalInjectTests.swift
//
// - Authors:
// Ben John
//
// - Date: 27.08.20
// swiftlint:disable nesting
// Copyright © 2020 Ben John. All rights reserved.

import XCTest
@testable import DIKit

class OptionalInjectTests: XCTestCase {
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
}
