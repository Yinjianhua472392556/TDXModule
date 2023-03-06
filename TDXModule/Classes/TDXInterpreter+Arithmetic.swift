//
//  TDXInterpreter+Arithmetic.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    public func handleArithmetic(_ node: TDXCallNode) -> Any {
        let f = TDXArithmeticFunc.type(node.name)
        switch f {
        case .unknown:
            TDXFuncError.unexpectedFunc(name: node.name).throwError()
            return TDXInvalidReturn
        case .not:
            return not(node)
        case .if:
            return ifFunc(node)
        case .iff:
            return iff(node)
        case .ifn:
            return ifn(node)
        case .max:
            return max(node)
        case .min:
            return min(node)
        }
    }
}


extension TDXInterpreter {
    
    /**
     求逻辑非。
     用法：　NOT(X)　返回非X，即当X=0时返回1，否则返回0。
     例如：　NOT(ISUP)表示平盘或收阴
     */
    func not(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        return asNumber(!asCondition(genericVisit(pr0))) ?? Double(0)
    }
    
    /**
     根据条件求不同的值。
     用法：　IF(X，A，B)　若X不为0则返回A，否则返回B。
     例如：　IF(CLOSE>OPEN,HIGH,LOW)表示该周期收阳则返回最高值,否则返回最低值
     */
    func ifFunc(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let pr2 = params[safe: 2] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        return asCondition(genericVisit(pr0)) ? genericVisit(pr1) : genericVisit(pr2)
    }
    
    /**
     根据条件求不同的值。
     用法：　IFF(X，A，B)　若X不为0则返回A，否则返回B。
     例如：　IFF(CLOSE>OPEN,HIGH,LOW)表示该周期收阳则返回最高值,否则返回最低值
     */
    func iff(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let pr2 = params[safe: 2] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        return asCondition(genericVisit(pr0)) ? genericVisit(pr1) : genericVisit(pr2)
    }
    
    /**
     根据条件求不同的值。
     用法：　IFN(X，A，B)　若X不为0则返回B，否则返回A。
     例如：　IFN(CLOSE>OPEN,HIGH,LOW)表示该周期收阴则返回最高值,否则返回最低值
     */
    func ifn(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let pr2 = params[safe: 2] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        return asCondition(genericVisit(pr0)) ? genericVisit(pr2) : genericVisit(pr1)
    }
    
    /**
     求最大值。
     用法：　MAX(A,B)　返回A和B中的较大值。
     例如：　MAX(CLOSE-OPEN,0)表示若收盘价大于开盘价返回它们的差值,否则返回0
     */
    func max(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        let p0 = asNumber(genericVisit(pr0))
        let p1 = asNumber(genericVisit(pr1))
        if let v0 = p0, let v1 = p1 {
            return Swift.max(v0, v1)
        }
        return p0 ?? p1 ?? TDXInvalidReturn
    }
    
    /**
     求最小值。
     用法：　MIN(A，B)　返回A和B中的较小值。
     例如：　MIN(CLOSE,OPEN)返回开盘价和收盘价中的较小值
     */
    func min(_ node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1] else {
            TDXFuncError.getParamFailed(name: node.name).throwError()
            return TDXInvalidReturn
        }
        let p0 = asNumber(genericVisit(pr0))
        let p1 = asNumber(genericVisit(pr1))
        if let v0 = p0, let v1 = p1 {
            return Swift.min(v0, v1)
        }
        return p0 ?? p1 ?? TDXInvalidReturn
    }

}
