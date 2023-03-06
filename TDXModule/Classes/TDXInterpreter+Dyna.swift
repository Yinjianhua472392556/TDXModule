//
//  TDXInterpreter+Dyna.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

extension TDXInterpreter {
    
    func handleDynamic(_ name: String) -> Any {
        guard let type = TDXDynamicFunc(rawValue: name) else {
            TDXFuncError.unexpectedFunc(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch type {
        case .unknown:
            return TDXInvalidReturn
//        case .dynainfo:
//            return dynaInfo()
        case .capital:
            return capital()
        }
    }
    
    func dynaInfo() -> Any {
        
        return TDXInvalidReturn
    }
    
    
    func capital() -> Any {
        return jobData?.capital ?? TDXInvalidReturn
    }
    
}
