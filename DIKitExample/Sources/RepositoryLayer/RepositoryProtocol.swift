// RepositoryProtocol.swift
//
// - Authors:
// Ben John
//
// - Date: 27.07.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

protocol RepositoryProtocol {
    var id: ObjectIdentifier { get }
    func list() -> String
}
