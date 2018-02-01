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
        container.register() { Network(url: "http://localhost") as NetworkProtocol }
        container.register() { Backend(network: try! container.resolve()) as BackendProtocol }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let network = try! container.resolve() as NetworkProtocol
        print(network)

        let backend = try! container.resolve() as BackendProtocol
        print(backend)

        return true
    }
}
