//
//  TDXInterpreter+Index.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    func handleIndex(_ name: String) -> Any {
        guard let type = TDXIndexFunc(rawValue: name) else {
            TDXFuncError.unexpectedFunc(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch type {
        case .unknown:
            return TDXInvalidReturn
        case .indexC:
            return indexC()
        }
    }
    
    func indexC() -> Any {
        return TDXInvalidReturn
    }
    
}
