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
    @Inject var defaultLocalStorage: LocalStorageProtocol
    @Inject("With just one parameter") var localStorageWithJustOneParameter: LocalStorageProtocol
    @Inject((name: "Local Storage with multiple parameters", other: 1)) var localStorageWithMultipleParameters: LocalStorageProtocol
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let result = backend.fetch()
        print(result)

        print(defaultLocalStorage.name)
        print(localStorageWithJustOneParameter.name)
        print(localStorageWithMultipleParameters.name)
    }
}
