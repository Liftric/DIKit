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
final class AppDelegate: BaseAppDelegate, DefinesContainer {
    let container = DependencyContainer.derive(from: .backend, .storage, .network)
}
