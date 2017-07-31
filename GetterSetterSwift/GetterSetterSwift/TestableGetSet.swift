//
//  TestableGetSet.swift
//  GetterSetterSwift
//
//  Created by DMITRY SINYOV on 28.07.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TestableGetSet: NSObject {
    private var internalTestField = ""
    private let internalQueue = DispatchQueue(label:"internalTestQueue", qos: .utility, attributes: .concurrent)
    private let internalLock = NSLock()
    //var testField = ""
    
//    var testField: String {
//        get {
//            return internalTestField
//        }
//        set (newFieldValue) {
//            internalTestField = newFieldValue
//        }
//    }
    
    //queue new syntax get
    var testField: String {
        get {
            return internalQueue.sync{
                internalTestField
            }
        }
        set (newFieldValue) {
            internalQueue.async(flags: .barrier) {
                self.internalTestField = newFieldValue
            }
        }
    }
    
    //queue old syntax get
//    var testField: String {
//        get {
//            var localField = ""
//            internalQueue.sync{
//                localField = internalTestField
//            }
//            return localField
//        }
//        set (newFieldValue) {
//            internalQueue.async(flags: .barrier) {
//                self.internalTestField = newFieldValue
//            }
//        }
//    }
    
    //mutex
//    var testField: String {
//        get {
//            internalLock.lock()
//            let localField = internalTestField
//            internalLock.unlock()
//            return localField
//        }
//        set (newFieldValue) {
//            internalLock.lock()
//            self.internalTestField = newFieldValue
//            internalLock.unlock()
//        }
//    }
}
