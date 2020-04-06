// StorageContext.swift
//
// - Authors:
// Cornelius Horstmann
//
// - Date: 06.04.2020
//
// Copyright © 2020 Cornelius Horstmann. All rights reserved.

import Foundation

/// The StorageContext describes the context some data can be stored in.
/// E.g. userdata should be wiped when the user logs out while systemdata should stay persisted.
enum StorageContext: String {
    case userdata
    case systemdata
}
