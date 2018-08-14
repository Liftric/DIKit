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
class AppDelegate: UIResponder, UIApplicationDelegate, DIKitProtocol {
    var window: UIWindow?

    let container = DependencyContainer.configure()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
