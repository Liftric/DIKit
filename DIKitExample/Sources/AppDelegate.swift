// AppDelegate.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import UIKit
import DIKit
import DIKitExampleBackend

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DefinesContainer {
    var window: UIWindow?
    let container = modules { .app; .backend }
}
