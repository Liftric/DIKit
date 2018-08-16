//
//  FirstViewController.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

protocol Dependency {
    var backend: BackendProtocol { get }
    var localStorage: LocalStorageProtocol { get }
}

class FirstViewController: UIViewController, HasDependencies {
    override func viewWillAppear(_ animated: Bool) {
        print(self.dependency.backend.fetch())
    }
}
