// Reflection.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.
    

import Foundation

class Reflection {
    class func getInstanceVariables(for object: AnyObject) -> [String: Any] {
        let classForCoder: AnyClass = type(of: object)
        var outCount = UInt32()
        let ivarList = class_copyIvarList(classForCoder, &outCount)

        var instanceVariables = [String: Any]()
        for i in 0 ..< Int(outCount) {
            guard let ivar: Ivar = ivarList?[i] else {
                continue
            }
            guard let ivarName = ivar_getName(ivar) else {
                continue
            }
            guard let ivarValue = object_getIvar(object, ivar) else {
                continue
            }
            let ivarReadableName = String(cString: ivarName)
            instanceVariables[ivarReadableName] = ivarValue
        }

        return instanceVariables
    }
}
