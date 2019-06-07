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
    @Injectable var backend: BackendProtocol
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = backend.fetch()
        print(result)
    }
}
