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
<<<<<<< HEAD
final class AppDelegate: BaseAppDelegate, DefinesContainer {
    let container = DependencyContainer.derive(containers: .backendContainer, .storageContainer, .networkContainer)
=======
class AppDelegate: UIResponder, UIApplicationDelegate, DefinesResolver {
    func resolver<DependencyResolver>() -> DependencyResolver {
        return DependencyResolverImpl() as! DependencyResolver
    }

    var window: UIWindow?
>>>>>>> feature/codegen
}
