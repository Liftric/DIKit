// SecondViewController.swift
//
// - Authors:
// Ben John
//
// - Date: 17.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import UIKit
import DIKit

class SecondViewController: UIViewController {
    // MARK: - DIKit
    let storage: LocalStorageProtocol = inject()

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(storage.id)
    }
}
