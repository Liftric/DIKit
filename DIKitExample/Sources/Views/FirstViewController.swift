// FirstViewController.swift
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

class FirstViewController: UIViewController {
    // MARK: - DIKit
    @Inject var backend: BackendProtocol
    @Inject("Local Storage with a custom name") var localStorage: LocalStorageProtocol
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = backend.fetch()
        print(result)

        print(localStorage.name)
    }
}
