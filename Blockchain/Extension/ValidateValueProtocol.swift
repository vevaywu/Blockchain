//
//  ValidateValueProtocol.swift
//  Blockchain
//
//  Created by Boni on 2021/4/25.
//

import UIKit

public protocol ValidateValueProtocol {
    associatedtype Object = Self
    init()
    static func validValue<T: Any>(_ data: T?) -> Object
}

public extension ValidateValueProtocol {
    static func validValue<T: Any>(_ data: T?) -> Object {
        switch self {
        case _ as String.Type:
            if data == nil {
                return "" as! Object
            }
            let rString = "\(data!)"
            if rString == "<null>" {
                return "" as! Object
            }
            return rString as! Object

        case _ as Bool.Type:
            if let result = data as? Bool {
                return result as! Object
            }
            return false as! Object
        case _ as Double.Type:
            if let rst = (data as AnyObject).doubleValue {
                return Double(rst) as! Object
            }
            return 0.0 as! Object
        case _ as CGFloat.Type:
            if let rst = (data as AnyObject).floatValue {
                return CGFloat(rst) as! Object
            }
            return CGFloat(0.0) as! Object
        case _ as Float.Type:
            if let rst = (data as AnyObject).floatValue {
                return Float(rst) as! Object
            }
            return Float(0.0) as! Object
        case _ as Int.Type:
//            if let rst = Int((data as AnyObject).doubleValue) as? Int {
//                return rst as! Object
//            }
            return Int(validDouble(data)) as! Object

        case _ as Int64.Type:
            if data == nil {
                return 0 as! Object
            } else {
                return (data as AnyObject).longLongValue as! Object
            }

        case _ as Date.Type:
            if let r = data as? Date {
                return r as! Object
            }
            return Date() as! Object

        case _ as NSDictionary.Type:
            if let nsDict = data as? NSDictionary {
                return nsDict as! Object
            }
            return NSDictionary() as! Object

        case _ as Dictionary<String, Any>.Type:
            if let dict = data as? Dictionary<String, Any> {
                return dict as! Object
            }
            return Dictionary<String, Any>() as! Object

        case _ as NSArray.Type:
            if let nsArray = data as? NSArray {
                return nsArray as! Object
            }
            return NSArray() as! Object

        case _ as Array<Any>.Type:
            if let r = data as? Array<Any> {
                return r as! Object
            }
            return Array<Any>() as! Object

        default:
            break
        }

        if let s = data as? Object {
            return s
        }

        return Self() as! Object
    }
}

extension Bool: ValidateValueProtocol { }
extension String: ValidateValueProtocol { }
extension NSString: ValidateValueProtocol { }
extension Double: ValidateValueProtocol { }
extension CGFloat: ValidateValueProtocol { }
extension Float: ValidateValueProtocol { }
extension Int: ValidateValueProtocol { }
extension Int64: ValidateValueProtocol { }
extension Date: ValidateValueProtocol { }
extension NSDictionary: ValidateValueProtocol { }
extension Dictionary: ValidateValueProtocol { }
extension NSArray: ValidateValueProtocol { }
extension Array: ValidateValueProtocol { }

public func validBool(_ data: Any?) -> Bool {
    return Bool.validValue(data)
}

public func validString(_ data: Any?) -> String {
    return String.validValue(data)
}

public func validNSString(_ data: Any?) -> NSString {
    return NSString.validValue(data)
}

public func validDouble(_ data: Any?) -> Double {
    return Double.validValue(data)
}

public func validCGFloat(_ data: Any?) -> CGFloat {
    return CGFloat.validValue(data)
}

public func validFloat(_ data: Any?) -> Float {
    return Float.validValue(data)
}

public func validInt(_ data: Any?) -> Int {
    return Int.validValue(data)
}

public func validInt64(_ data: Any?) -> Int64 {
    return Int64.validValue(data)
}

public func validDate(_ data: Any?) -> Date {
    return Date.validValue(data)
}

public func validNSDictionary(_ data: Any?) -> NSDictionary {
    return NSDictionary.validValue(data)
}

public func validDictionary(_ data: Any?) -> Dictionary<String, Any> {
    return Dictionary.validValue(data)
}

public func validArray(_ data: Any?) -> Array<Any> {
    return Array.validValue(data)
}

public func unwrap<T: Any>(_ data: T?) -> T.Object where T: ValidateValueProtocol {
    return T.validValue(data)
}
