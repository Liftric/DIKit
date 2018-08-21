// Network.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


class Network: NetworkProtocol {
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }

    init() {
        print("Network instance \(ObjectIdentifier.init(self))")
    }

    deinit {
        print("Network instance \(ObjectIdentifier.init(self)) deinit.")
    }
}
