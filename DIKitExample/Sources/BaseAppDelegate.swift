//
//  BaseAppDelegate.swift
//  DIKitExample
//
//  Created by Ben John on 15.08.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

class BaseAppDelegate: UIResponder, UIApplicationDelegate, DIKitProtocol {
    var window: UIWindow?
    let container = DependencyContainer.configure()
}
