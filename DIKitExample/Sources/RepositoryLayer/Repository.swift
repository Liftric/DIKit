// Repository.swift
//
// - Authors:
// Ben John
//
// - Date: 27.07.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

class Repository: RepositoryProtocol {
    func list() -> String {
        return self.backend.fetch()
    }
    
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }
    
    let backend: BackendProtocol
    let storage: LocalStorageProtocol
    
    init(backend: BackendProtocol, storage: LocalStorageProtocol) {
        self.backend = backend
        self.storage = storage
        print("Repository init with backend \(backend.id) and storage \(storage.id)")
        print("Repository instance \(ObjectIdentifier.init(self))")
    }
    
    deinit {
        print("Repository instance \(ObjectIdentifier.init(self)) deinit.")
    }
}
