//
//  SecondViewController.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

protocol SecondViewControllerDependency {
    var localStorage: LocalStorageProtocol { get }
}

class SecondViewController: UIViewController, HasDependencies {
    typealias Dependency = SecondViewControllerDependency
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.dependency.localStorage.id)
    }
}
