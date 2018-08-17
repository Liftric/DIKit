// ModalViewController.swift
//
// - Authors:
// Ben John
//
// - Date: 16.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import UIKit
import DIKit

class ModalViewController: UIViewController, HasDependencies {
    // MARK: - DIKit
    struct Dependency {
        let backend: BackendProtocol
        let localStorage: LocalStorageProtocol
    }
    var dependency: Dependency!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Dependency.inject(into: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.dependency.backend.fetch())
    }
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Actions
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true)
    }
}
