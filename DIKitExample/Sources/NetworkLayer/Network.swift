//
//  Network.swift
//  DIKitExample
//
//  Created by Ben John on 01.02.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

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
