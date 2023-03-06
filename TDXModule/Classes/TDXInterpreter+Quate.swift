//
//  TDXInterpreter+Quate.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    public func handleQuote(_ name: String) -> Any {
        let f = TDXQuateFunc.type(name)
        guard let p = firstData() else {
            TDXFuncError.getQuateDataFailed(name: name).throwError()
            return TDXInvalidReturn
        }
        switch f {
        case .unknown:
            return TDXInvalidReturn
        case .high:
            return high(p)
        case .h:
            return high(p)
        case .low:
            return low(p)
        case .l:
            return low(p)
        case .close:
            return close(p)
        case .c:
            return close(p)
        case .vol:
            return vol(p)
        case .v:
            return vol(p)
        case .open:
            return open(p)
        case .o:
            return open(p)
        case .amount:
            return amount(p)
        case .advance:
            return TDXInvalidReturn
        case .decline:
            return TDXInvalidReturn
        case .zstjj:
            return TDXInvalidReturn
//            return zstjj()
        }
    }
    
    
    func firstData() -> Any? {
        let idx = dataIndex()
//        if let d = asKineDrawData(data) {
//            return d[safe: idx]
//        }else if let d = asMinDrawData(data) {
//            return d[safe: idx]
//        }
        return nil
    }

    
    func high(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.highReal)
//        }else if let m = asMin(param) {
////            return m.price
//            return Double(m.closeReal)
//        }
        return TDXInvalidReturn
    }
    
    
    func open(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.openReal)
//        }else if let m = asMin(param) {
////            return m.price
//            return Double(m.openReal)
//
//        }
        return TDXInvalidReturn
    }
    
    func low(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.lowReal)
//        }else if let m = asMin(param) {
////            return m.price
//            return Double(m.lowReal)
//
//        }
        return TDXInvalidReturn
    }
    
    func close(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.closeReal)
//        }else if let m = asMin(param) {
////            return m.price
//            return Double(m.closeReal)
//
//        }
        return TDXInvalidReturn
    }
    
    func vol(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.volume) / 100
//        }else if let m = asMin(param) {
//            return Double(m.volume) / 100
//        }
        return TDXInvalidReturn
    }
    
    func amount(_ param: Any) -> Double {
//        if let k = asKine(param) {
//            return Double(k.amount)
//        }else if let m = asMin(param) {
//            return Double(m.amount)
//        }
        return TDXInvalidReturn
    }

    /// 分时图均价：返回该周期的分时图均价线,对于分时图周期指标有效
//    func zstjj() -> Double {
//        
//        if let zstjj = jobData?.zstjj, zstjj != TDXInvalidReturn { return zstjj }
//        
//        if data.isEmpty { return 0 }
//        
//        var total = 0.0
//        if (data.first as? DYRtmin) != nil {
//            data.forEach { tmp in
//                guard let min = tmp as? DYRtmin else { return }
//                total += Double(min.closeReal)
//            }
//        } else {
//            return TDXInvalidReturn
//        }
//        
//        return total / Double(data.count)
//    }
    
}
