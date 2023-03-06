//
//  TDXInterpreter+Math.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation


extension TDXInterpreter {
    
    func handleMath(_ node: TDXCallNode) -> Any {
        let name = node.name
        guard let type = TDXMathFunc(rawValue: name) else {
            TDXFuncError.unexpectedFunc(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch type {
        case .unknow:
            return TDXInvalidReturn
        case .acos:
            return tdx_acos(node: node)
        case .asin:
            return tdx_asin(node: node)
        case .atan:
            return tdx_atan(node: node)
        case .cos:
            return tdx_cos(node: node)
        case .sin:
            return tdx_sin(node: node)
        case .tan:
            return tdx_tan(node: node)
        case .exp:
            return tdx_exp(node: node)
        case .ln:
            return mathLn(node: node)
        case .log:
            return mathLog(node: node)
        case .sqrt:
            return mathSprt(node: node)
        case .abs:
            return mathAbs(node: node)
        case .pow:
            return mathPow(node: node)
        case .ceiling:
            return mathCeiling(node: node)
        case .floor:
            return mathFloor(node: node)
        case .intpart:
            return mathIntpart(node: node)
        case .between:
            return mathBetween(node: node)
        }
    }
    
    func tdx_acos(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { acos($0) }
    }
    
    func tdx_asin(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { asin($0) }
    }
    
    func tdx_atan(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { atan($0) }
    }
    
    func tdx_cos(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { cos($0) }
    }
    
    func tdx_sin(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { sin($0) }
    }
    
    func tdx_tan(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { tan($0) }
    }
    
    func tdx_exp(node: TDXCallNode) -> Any {
        return calculateValue(node: node) { exp($0) }
    }
    
    func calculateValue(node: TDXCallNode, math: ((_ value: Double) -> Double)) -> Any {
        guard let para = node.params.first,
              let value = asNumber(genericVisit(para)) else { return TDXInvalidReturn }
        let result = math(value)
        return result.isNaN ? TDXInvalidReturn : result
    }
    
    func mathLn(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            return log(Double(p0))
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathLog(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        guard let p0 = asNumber(genericVisit(pr0)) else { return TDXInvalidReturn }
        return log10(p0)
    }

    func mathSprt(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            return sqrt(p0)
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathAbs(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            return fabs(p0)
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathPow(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        if let p0 = asNumber(genericVisit(pr0)), let p1 = asNumber(genericVisit(pr1))  {
            return pow(p0, p1)
        }
        
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathCeiling(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            
            return ceil(p0)
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathFloor(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            
            return floor(p0)
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathIntpart(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        if let p0 = asNumber(genericVisit(pr0)) {
            if p0 >= 0 {
                return floor(p0)
            }else {
                let temp = floor(p0)
                if fabs(temp) > fabs(p0) {
                    return temp + 1
                }else {
                    return temp
                }
            }
        }
        TDXFuncError.getParamFailed(name: node.name).throwError()
        return TDXInvalidReturn
    }
    
    func mathBetween(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let pr2 = params[safe: 2] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
     
        guard let p0 = asNumber(genericVisit(pr0)),
              let p1 = asNumber(genericVisit(pr1)),
              let p2 = asNumber(genericVisit(pr2)) else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        let result: Int
        if p1 >= p2 {
            result = p0 <= p1 && p0 >= p2 ? 1 : 0
        } else if p2 > p1 {
            result = p0 <= p2 && p0 >= p1 ? 1 : 0
        } else {
            result = 0
        }
        debugPrint(result)
        return result
    }
    
}
