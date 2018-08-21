// Backend.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import DIKit

class Backend: BackendProtocol {
    // MARK: - DIKit
    let network: NetworkProtocol = inject()

    // MARK: - Backend related stuff
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }
    
    init() {
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
