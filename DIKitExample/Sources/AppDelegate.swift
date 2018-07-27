//
//  AppDelegate.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let container = DependencyContainer { container in
        container.register(as: .singleton) { Network(url: "http://localhost") as NetworkProtocol }
        container.register(as: .singleton) { Backend(network: container.resolve()) as BackendProtocol }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        var backend: BackendProtocol = container.resolve()
        backend = container.resolve()
        backend = container.resolve()
        print(backend.fetch())

        return true
    }
}

