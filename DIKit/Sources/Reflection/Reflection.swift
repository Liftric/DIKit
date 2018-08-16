// Reflection.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation
import ObjectiveC.runtime

class Reflection {
    class func getInstanceVariables(for object: AnyObject,
                                    matches prefix: String = "__",
                                    instanceVariables: [String: Any] = [String: Any](),
                                    includeSuperclass: Bool = true,
                                    root: AnyObject? = nil) -> [String: Any] {

        guard object.classForCoder != NSObject.self else {
            return instanceVariables
        }

        let accessibleObject = root ?? object
        var outCount = UInt32()
        let ivarList = class_copyIvarList(object.classForCoder, &outCount)

        var instanceVariables = instanceVariables
        for i in 0 ..< Int(outCount) {
            guard let ivar: Ivar = ivarList?[i] else {
                continue
            }
            guard let ivarName = ivar_getName(ivar) else {
                continue
            }
            let ivarReadableName = String(cString: ivarName)
            guard ivarReadableName.starts(with: prefix) else {
                continue
            }
            guard let ivarValue = object_getIvar(accessibleObject, ivar) else {
                continue
            }
            instanceVariables[ivarReadableName] = ivarValue
        }

        guard includeSuperclass else {
            return instanceVariables
        }

        guard let superclazzInstance: AnyObject = object.superclass else {
            return instanceVariables
        }

        return getInstanceVariables(for: superclazzInstance,
                                    instanceVariables: instanceVariables,
                                    includeSuperclass: false,
                                    root: object)
    }
}
