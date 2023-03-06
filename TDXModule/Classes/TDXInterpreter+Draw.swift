//
//  TDXInterpreter+Draw.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    public func handleDraw(_ node: TDXCallNode) -> Any {
        let f = TDXDrawFunc.type(node.name)
        let params = node.params
        switch f {
        case .unknown:
            return TDXInvalidReturn
        case .ployline:
            guard let pr0 = params.first else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let v0 = genericVisit(pr0)
            guard asCondition(v0) else {
                return TDXInvalidReturn
            }
            
            guard let pr1 = params[safe: 1],
                  let p1 = asNumber(genericVisit(pr1)) else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            
            let draw = TDXDrawPloyline(id: id, key: node.token.key, drawType: drawType)
            draw.price = p1
            return draw
        case .line:
            return TDXInvalidReturn
        case .kine:
            guard let pr0 = params.first,
                  let pr1 = params[safe: 1],
                  let pr2 = params[safe: 2],
                  let pr3 = params[safe: 3] else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            guard let p0 = asNumber(genericVisit(pr0)),
                  let p1 = asNumber(genericVisit(pr1)),
                  let p2 = asNumber(genericVisit(pr2)),
                  let p3 = asNumber(genericVisit(pr3)) else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            ///根据cond处理data
            let draw = TDXDrawKine(id: id, key: node.token.key, drawType: drawType)
            draw.high = p0
            draw.open = p1
            draw.low = p2
            draw.close = p3
            return draw
        case .stickline:
            guard let pr0 = params.first else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let v0 = genericVisit(pr0)
            guard asCondition(v0) else {
                return TDXInvalidReturn
            }
            guard let pr1 = params[safe: 1],
                  let pr2 = params[safe: 2],
                  let pr3 = params[safe: 3],
                  let pr4 = params[safe: 4] else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            guard let p1 = asNumber(genericVisit(pr1)),
                  let p2 = asNumber(genericVisit(pr2)),
                  let p3 = asNumber(genericVisit(pr3)) else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let draw = TDXDrawStickline(id: id, key: node.token.key, drawType: drawType)
            draw.price1 = p1
            draw.price2 = p2
            draw.width = p3
            draw.isEmpty = asCondition(genericVisit(pr4))
            return draw
        case .icon:
            guard let pr0 = params.first else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let v0 = genericVisit(pr0)
            guard asCondition(v0) else {
                return TDXInvalidReturn
            }
            guard let pr1 = params[safe: 1],
                  let pr2 = params[safe: 2] else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            guard let p1 = asNumber(genericVisit(pr1)),
                  let p2 = asNumber(genericVisit(pr2)) else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let draw = TDXDrawIcon(id: id, key: node.token.key, drawType: drawType)
            draw.price = p1
            draw.type = Int(p2)
            return draw
        case .text:
            guard let pr0 = params.first else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let v0 = genericVisit(pr0)
            guard asCondition(v0) else {
                return TDXInvalidReturn
            }
            guard let pr1 = params[safe: 1],
                  let pr2 = params[safe: 2] else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            guard let p1 = asNumber(genericVisit(pr1)),
                  let p2 = asString(genericVisit(pr2)) else {
                TDXFuncError.getParamFailed(name: node.name).throwError()
                return TDXInvalidReturn
            }
            let draw = TDXDrawText(id: id, key: node.token.key, drawType: drawType)
            draw.price = p1
            draw.text = p2
            return draw
        }
    }
    
}
