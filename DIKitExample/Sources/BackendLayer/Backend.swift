//
//  Backend.swift
//  DIKitExample
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

class Backend: BackendProtocol {
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }
    
    init(network: NetworkProtocol) {
        print("Backend init with network \(network.id)")
        print("Backend instance \(ObjectIdentifier.init(self))")
    }

    deinit {
        print("Backend instance \(ObjectIdentifier.init(self)) deinit.")
    }
    
    func fetch() -> String {
        return "Test"
    }
}

