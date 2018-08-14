// DependencyContainer.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import DIKit

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            container.register(as: .singleton) { Network(url: "http://localhost") as NetworkProtocol }
            container.register(as: .singleton) { Backend(network: container.resolve()) as BackendProtocol }
            container.register(as: .prototype) { LocalStorage() as LocalStorageProtocol }
            container.register(as: .prototype) { Repository(backend: container.resolve(), storage: container.resolve()) as RepositoryProtocol }
        }
    }
}
