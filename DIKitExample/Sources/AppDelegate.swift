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
        container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
        container.register(as: .prototype) {
            Repository(backend: container.resolve(),
                       storage: container.resolve()) as RepositoryProtocol
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        listData()
        listData()
        listData()

        return true
    }
    
    func listData() {
        let repository: RepositoryProtocol = container.resolve()
        print(repository.list())
    }
}

