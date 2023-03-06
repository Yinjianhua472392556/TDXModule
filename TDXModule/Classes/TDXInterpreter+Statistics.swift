//
//  TDXInterpreter+Statistics.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

//  板块的函数有问题，目前没有根据板块名获取板块信息的相关接口，做不了

import Foundation

extension TDXInterpreter {
    
    func handleStatistics(_ node: TDXCallNode) -> Any {
        let name = node.name
        guard let type = TDXStatisticsFunc(rawValue: name) else {
            TDXFuncError.unexpectedFunc(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch type {
        case .unknown:
            return TDXInvalidReturn
        case .blocksetnum:
            return blocksetnum(node: node)
        case .horcalc:
            return horcalc(node: node)
        case .varFunc:
            return varFunc(node: node)
        }
    }
    
    func blocksetnum(node: TDXCallNode) -> Any {
//        guard let num = jobData?.blockSetSum else { return TDXInvalidReturn }
//        return num
        return TDXInvalidReturn
    }
    
    func horcalc(node: TDXCallNode) -> Any {
        return TDXInvalidReturn
    }
    
    ///估算样本方差
    func varFunc(node: TDXCallNode) -> Any {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let p1 = asNumber(genericVisit(pr1)) else {
            return TDXInvalidReturn
        }
        let param = Int(p1)
        guard param > 1 else {
            return TDXInvalidReturn
        }
        let end = dataIndex()
        let start = end - param + 1
        guard start >= 0, end >= start else {
            return TDXInvalidReturn
        }
        var tData = [Double]()
        ///获取所有的值
        for i in start...end {
            saveDataIndex(i)
            if let v = asNumber(genericVisit(pr0)) {
                tData.append(v)
            }
        }
        let ma = tData.sum() / p1
        let s = tData.map({ pow($0 - ma, 2) }).sum() / (p1 - 1)
        return s
    }
    
}
