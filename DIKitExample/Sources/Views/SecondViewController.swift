//
//  SecondViewController.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

class SecondViewController: UIViewController, HasDependencies {
    // MARK: - Dependency declaration
    struct Dependency: HasContainerContext {
        let storage: LocalStorageProtocol = container.resolve()
    }
    var dependency: Dependency! = Dependency()

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(dependency.storage.id)
    }
}
