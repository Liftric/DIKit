//
//  DIKit.swift
//  DIKit
//
//  Created by Ben John on 31.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import Foundation

internal extension Bundle {
    class var framework: Bundle {
        return Bundle(for: DIKitMaker.self)
    }
}

private class DIKitMaker {}
