//
//  FirstViewController.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

protocol FirstViewControllerDependency {
    var backend: BackendProtocol { get }
    var localStorage: LocalStorageProtocol { get }
}

class FirstViewController: UIViewController, HasDependencies {
    typealias Dependency = FirstViewControllerDependency
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.dependency.backend.fetch())
    }
}
