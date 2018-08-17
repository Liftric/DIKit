//
//  Backend.swift
//  DIKitExample
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation
import DIKit

class Backend: BackendProtocol, HasDependencies {
    // MARK: - Dependency declaration
    struct Dependency: HasContainerContext {
        let network: NetworkProtocol = container.resolve()
    }
    var dependency: Dependency! = Dependency()

    // MARK: - Backend related stuff
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }
    
    init() {
        print("Backend init with network \(dependency.network.id)")
        print("Backend instance \(ObjectIdentifier.init(self))")
    }

    deinit {
        print("Backend instance \(ObjectIdentifier.init(self)) deinit.")
    }
    
    func fetch() -> String {
        return "Test"
    }
}

