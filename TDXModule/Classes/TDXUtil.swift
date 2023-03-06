//
//  TDXUtil.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation


///无效返回值
public let TDXInvalidReturn = Double.infinity
///无效int值
public let TDXInvalidInt = -1
public typealias TDXDrawData = [Any]

func isInvalidInt(_ idx: Int) -> Bool {
    return TDXInvalidInt == idx
}


///转换成条件值
func asCondition(_ cond: Any) -> Bool {
    if let c = asBool(cond) {
        return c
    }
    if let c = asDouble(cond) {
        return c != 0
    }
    if let c = asInt(cond) {
        return c != 0
    }
    return false
}


///转换成数值
func asNumber(_ p: Any?) -> Double? {
    if let n = asDouble(p) {
        return n
    }else if let n = asInt(p) {
        return Double(n)
    }else if let n = asBool(p) {
        return n ? Double(1) : Double(0)
    }else {
        return nil
    }
}

func asInt(_ p: Any?) -> Int? {
    return p as? Int
}

func asDouble(_ p: Any?) -> Double? {
    let d = p as? Double
    return d == TDXInvalidReturn ? nil : d
}

func asBool(_ p: Any?) -> Bool? {
    return p as? Bool
}

func asString(_ p: Any?) -> String? {
    return p as? String
}


//func asKineDrawData(_ p: TDXDrawData) -> [DYKLine]? {
//    return p as? [DYKLine]
//}
//
//func asMinDrawData(_ p: TDXDrawData) -> [DYRtmin]? {
//    return p as? [DYRtmin]
//}
//
//func asKine(_ p: Any) -> DYKLine? {
//    return p as? DYKLine
//}
//
//func asMin(_ p: Any) -> DYRtmin? {
//    return p as? DYRtmin
//}


extension String {
    
    @discardableResult
    mutating func slice(from index: Int, length: Int) -> String {
        if let str = slicing(from: index, length: length) {
            self = String(str)
        }
        return self
    }
    
    func slicing(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < count  else { return nil }
        guard index.advanced(by: length) <= count else {
            return self[safe: index..<count]
        }
        guard length > 0 else { return "" }
        return self[safe: index..<index.advanced(by: length)]
    }
    
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
            let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
                return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    var isVar: Bool {
        let reg = "^[a-zA-Z0-9\u{4e00}-\u{9fa5}]+$"
        let pre = NSPredicate(format: "SELF MATCHES %@", reg)
        return pre.evaluate(with: self)
    }
    
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
