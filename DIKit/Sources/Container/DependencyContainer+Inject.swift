// DependencyContainer+Inject.swift
//
// - Authors:
// Ben John
//
// - Date: 14.08.18
//
// Copyright © 2018 Ben John. All rights reserved.


import Foundation

extension DependencyContainer {
    public func inject(into object: AnyObject) {
        // Currently only works for `NSObject` classes.
        let classForCoder: AnyClass = type(of: object)

        var outCount = UInt32()
        let ivarList = class_copyIvarList(classForCoder, &outCount)

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
            guard let dependency = ivarValue as? DependencyProtocol else {
                continue
            }

            let ivarReadableName = String(cString: ivarName)
            print("Dependency variable `\(ivarReadableName)` was found, inject service.")

            dependency.inject(with: self)
            object_setIvar(object, ivar, dependency)
        }
    }
}
