// LocalStorage.swift
//
// - Authors:
// Ben John
//
// - Date: 27.07.18
//
// Copyright © 2018 Ben John. All rights reserved.


class LocalStorage: LocalStorageProtocol {
    var id: ObjectIdentifier {
        return ObjectIdentifier.init(self)
    }
    let name: String
    
    init(name: String) {
        self.name = name
        print("LocalStorage init")
        print("LocalStorage instance \(ObjectIdentifier.init(self))")
    }
    
    deinit {
        print("LocalStorage instance \(ObjectIdentifier.init(self)) deinit.")
    }
}
