//
//  Backend.swift
//  DIKitExample
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

class Backend: BackendProtocol {
    init() {
        print("Backend init")
    }
    
    func fetch() -> String {
        return "Test"
    }
}
