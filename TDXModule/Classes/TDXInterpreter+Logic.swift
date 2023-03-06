//
//  TDXInterpreter+Logic.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    func handleLogic(_ node: TDXCallNode) -> Any {
        
        let f = TDXLogicFunc.type(node.name)
        guard firstData() != nil else {
            TDXFuncError.getLogicFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        switch f {
        case .unknown:
            return TDXInvalidReturn
        case .cross:
            return cross(node.params)
        case .longcross:
            return longCross(node)
        case .upnday:
            return upNDay(node)
        case .downnday:
            return downNDay(node)
        case .nday:
            return nDay(node)
        case .exist:
            return exist(node)
        case .every:
            return every(node)
        case .last:
            return last(node)
        }
    }
    
    func cross(_ params: [TDXNode]) -> Any {
        let index = dataIndex()
//        guard let kline = data[safe: index] as? DYKLine,
//              let p0 = params[safe: 0],
//              let p1 = params[safe: 1] else { return TDXInvalidReturn }
//        guard index >= 0 else { return TDXInvalidReturn }
//        guard let a = asNumber(genericVisit(p0)), let b = asNumber(genericVisit(p1)) else { return TDXInvalidReturn }
//        saveDataIndex(index-1)
//        guard let la = asNumber(genericVisit(p0)), let lb = asNumber(genericVisit(p1)) else { return TDXInvalidReturn }
//        return (la < lb && a > b) ? 1 : 0
        
        return TDXInvalidReturn
    }
    
    func longCross(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pn = params[safe: 2],
//              let nDouble = asNumber(genericVisit(pn)),
//              let pa = params[safe: 0],
//              let pb = params[safe: 1] else { return TDXInvalidReturn }
//        let n     = Int(nDouble)
//        let index = dataIndex()
//        var end   = index
//        var start = end - n
//        guard start >= 0 else { return TDXInvalidReturn }
//        guard n > 0 else { return 0 }
//        var result = 1
//        for j in start...end {
//            saveDataIndex(j)
//            guard let a = asNumber(genericVisit(pa)),
//                  let b = asNumber(genericVisit(pb)) else { return TDXInvalidReturn }
//            switch j {
//            case start..<end:
//                if (a < b) == false {
//                    result = 0
//                    break
//                }
//            case end:
//                if (a > b) == false {
//                    result = 0
//                    break
//                }
//            default:
//                result = 0
//                break
//            }
//        }
//        return result
        
        
        return TDXInvalidReturn
    }
    
    func upNDay(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pm = params[safe: 1],
//              let mDouble = asNumber(genericVisit(pm)),
//              let pv = params[safe: 0] else { return TDXInvalidReturn }
//        let m = Int(mDouble)
//        let index = dataIndex()
//        var end = index
//        var start = end - m
//        guard start >= 0 else { return TDXInvalidReturn }
//        guard m > 0 else { return 0 }
//        var result = 1
//        var value = -1.0
//        for j in start...end {
//            saveDataIndex(j)
//            guard let iValue = asNumber(genericVisit(pv)) else {
//                result = 0
//                break
//            }
//
//            if j == start {
//                value = iValue
//                continue
//            }
//
//            if iValue <= value {
//                result = 0
//                break
//            }
//
//            value = iValue
//        }
//        return result
        
        return TDXInvalidReturn
    }
    
    func downNDay(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pm = params[safe: 1],
//              let mDouble = asNumber(genericVisit(pm)),
//              let pv = params[safe: 0] else { return TDXInvalidReturn }
//        let m     = Int(mDouble)
//        let index = dataIndex()
//        var end   = index
//        var start = end - m
//        guard start >= 0 else { return TDXInvalidReturn }
//        guard m > 0 else { return 0 }
//        var result = 1
//        var value = -1.0
//        for j in start...end {
//            saveDataIndex(j)
//
//            guard let iValue = asNumber(genericVisit(pv)) else {
//                result = 0
//                break
//            }
//
//            if j == start {
//                value = iValue
//                continue
//            }
//
//            if iValue >= value {
//                result = 0
//                break
//            }
//
//            value = iValue
//        }
//        return result
        
        return TDXInvalidReturn
    }
    
    func nDay(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pm = params[safe: 2],
//              let mDouble = asNumber(genericVisit(pm)),
//              let px = params[safe: 0],
//              let py = params[safe: 1] else { return TDXInvalidReturn }
//        let m = Int(mDouble)
//        let index = dataIndex()
//        var end = index
//        var start = end - (m-1)
//        guard start >= 0 else { return TDXInvalidReturn }
//        guard m > 0 else { return 0 }
//        var result = 1
//        for j in start...end {
//            saveDataIndex(j)
//            guard let x = asNumber(genericVisit(px)),
//                  let y = asNumber(genericVisit(py)) else {
//                result = 0
//                break
//            }
//            if x <= y {
//                result = 0
//                break
//            }
//        }
//        return result
        
        return TDXInvalidReturn
    }
    
    func exist(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pm = params[safe: 1],
//              let mDouble = asNumber(genericVisit(pm)),
//              let p0 = params[safe: 0] else { return TDXInvalidReturn }
//        let index = dataIndex()
//        let m     = Int(mDouble)
//        var end   = index
//        var start = end - (m-1)
//        guard start >= 0 else { return TDXInvalidReturn }
//
//        var result = 0
//        for j in start...end {
//            saveDataIndex(j)
//            if asCondition(genericVisit(p0)) {
//                result = 1
//                break
//            }
//        }
//        return result
        
        return TDXInvalidReturn
    }
    
    func every(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let pm = params[safe: 1],
//              let mDouble = asNumber(genericVisit(pm)),
//              let p0 = params[safe: 0] else { return TDXInvalidReturn }
//        let index = dataIndex()
//        let m     = Int(mDouble)
//        var end   = index
//        var start = end - (m-1)
//        guard start >= 0 else { return TDXInvalidReturn }
//        var result = 1
//        for j in start...end {
//            saveDataIndex(j)
//            if asCondition(genericVisit(p0)) == false {
//                result = 0
//                break
//            }
//        }
////        let date = Date(timeIntervalSince1970: TimeInterval(klines[index].tradingDay)).string(withFormat: "yyyy-MM-dd")
////        debugPrint("date:\(date), m:\(m), start:\(start), end:\(end), result:\(result)")
//        return result
        
        
        return TDXInvalidReturn
    }
    func last(_ node: TDXCallNode) -> Any {
        let params = node.params
//        guard let klines = data as? [DYKLine] else { return TDXInvalidReturn }
//        guard let px = params[safe: 0],
//              let pa = params[safe: 1],
//              let pb = params[safe: 2],
//              let aValue = asNumber(genericVisit(pa)),
//              let bValue = asNumber(genericVisit(pb)) else { return TDXInvalidReturn }
//        let a = Int(aValue)
//        let b = Int(bValue)
//        guard a > b,
//              a >= 0,
//              b >= 0,
//              dataIndex() >= a else { return TDXInvalidReturn }
//        var start = dataIndex() - a
//        var end = dataIndex() - b
//        var result = 1
//        for j in start...end {
//            saveDataIndex(j)
//            if asCondition(genericVisit(px)) == false {
//                result = 0
//                break
//            }
//        }
//        return result
        
        
        return TDXInvalidReturn
    }
}
