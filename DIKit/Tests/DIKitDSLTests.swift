// DIKitDSLTests.swift
//
// - Authors:
// Ben John
//
// - Date: 27.08.20
// Copyright © 2020 Ben John. All rights reserved.

import XCTest
@testable import DIKit

class DIKitDSLTests: XCTestCase {
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
        let dependencyContainerD = module {
            single(tag: "tag") { ComponentC() }
        }

        let dependencyContainer = modules {
            dependencyContainerA
            dependencyContainerB
            dependencyContainerC
            dependencyContainerD
        }

        let componentA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentA)

        let componentB: ComponentB = dependencyContainer.resolve()
        XCTAssertNotNil(componentB)

        let componentC: ComponentC = dependencyContainer.resolve()
        XCTAssertNotNil(componentC)

        let taggedComponentC: ComponentC = dependencyContainer.resolve(tag: "tag")
        XCTAssertNotNil(taggedComponentC)
    }

    func testFactoryOfComponentsDSL() {
        class ComponentA {}

        let dependencyContainer = module {
            factory { ComponentA() }
        }

        let componentAinstanceA: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceA)
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
            let dependencyContainerD = module {
                single(tag: "tag") { ComponentC() }
            }

            let dependencyContainer = modules {
                dependencyContainerA
                dependencyContainerB
                dependencyContainerC
                dependencyContainerD
            }

            let componentA: ComponentA = dependencyContainer.resolve()
            XCTAssertNotNil(componentA)

            let componentB: ComponentB = dependencyContainer.resolve()
            XCTAssertNotNil(componentB)

            let componentC: ComponentC = dependencyContainer.resolve()
            XCTAssertNotNil(componentC)

            let taggedComponentC: ComponentC = dependencyContainer.resolve(tag: "tag")
            XCTAssertNotNil(taggedComponentC)
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
        let componentAinstanceB: ComponentA = dependencyContainer.resolve()
        XCTAssertNotNil(componentAinstanceB)

        let componentAinstanceAobjectIdA = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceAobjectIdB = ObjectIdentifier(componentAinstanceA)
        let componentAinstanceBobjectId = ObjectIdentifier(componentAinstanceB)

        XCTAssertEqual(componentAinstanceAobjectIdA, componentAinstanceAobjectIdB)
        XCTAssertNotEqual(componentAinstanceAobjectIdA, componentAinstanceBobjectId)
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
