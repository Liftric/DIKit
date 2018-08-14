//
//  FirstViewController.swift
//  DIKitExample
//
//  Created by Ben John on 12.01.18.
//  Copyright © 2018 Ben John. All rights reserved.
//

import UIKit
import DIKit

class FirstViewController: UIViewController {
    let backend = Dependency<BackendProtocol>()

    override func viewDidLoad() {
        super.viewDidLoad()
        DIKit.inject(into: self)
    }
}
