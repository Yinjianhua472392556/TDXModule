//
//  TDXSymbol.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

/**
 符号类型
 */
public enum TDXSymbolType: String {
    case assignVar
    case assignPlotVar
}

/**
 符号类
 */
public class TDXSymbol {
    let name: String
    var level: Int = 0
    var type: String = ""
    
    init(name: String, level: Int, type: String) {
        self.name = name
        self.level = level
        self.type = type
    }
}

///Int符号类
public class TDXIntSymbol: TDXSymbol {
    var value: Int?
}

///变量符号类
public class TDXVarSymbol: TDXSymbol {
    var value: TDXNode?
    ///缓存的计算后的结果值
    var cacheValue: Any?
}

public class TDXFuncSymbol: TDXSymbol {
    ///参数
    var params: [TDXNode]?
    ///函数体
    var block: TDXCompoundNode?
    ///缓存的计算后的结果值
    var cacheValue: Any?
}

///Int符号类
public class TDXParamSymbol: TDXSymbol {
    var value: TDXNode?
    ///缓存的计算后的结果值
    var cacheValue: Any?
}

public class TDXScopedSymbolTable {
    
    ///名称
    let name: String
    ///级别
    let level: Int
    ///外层作用域
    var encloseingScope: TDXScopedSymbolTable?

    private var symbols = [String: TDXSymbol]()

    static let noCacheScope = [TDXRefFunc.ref.rawValue,
                                TDXRefFunc.dma.rawValue,
                                TDXRefFunc.ema.rawValue,
                                TDXRefFunc.mema.rawValue,
                                TDXRefFunc.sma.rawValue,
                                TDXRefFunc.ma.rawValue,
                                TDXRefFunc.sumBars.rawValue,
                                TDXRefFunc.barsCount.rawValue,
                                TDXRefFunc.barsLast.rawValue,
                                TDXRefFunc.barsSince.rawValue,
                                TDXRefFunc.barsLastCount.rawValue,
                                TDXRefFunc.const.rawValue,
                                TDXRefFunc.refDate.rawValue,
                                TDXRefFunc.hhv.rawValue,
                                TDXRefFunc.llv.rawValue,
                                TDXRefFunc.count.rawValue,
                                TDXRefFunc.hhvbars.rawValue,
                                TDXRefFunc.llvbars.rawValue,
                                TDXRefFunc.sum.rawValue,
                                TDXLogicFunc.longcross.rawValue,
                                TDXLogicFunc.upnday.rawValue,
                                TDXLogicFunc.downnday.rawValue,
                                TDXLogicFunc.nday.rawValue,
                                TDXLogicFunc.exist.rawValue,
                                TDXLogicFunc.every.rawValue,
                                TDXLogicFunc.last.rawValue]
    
    init(name: String,
         level: Int,
         encloseingScope: TDXScopedSymbolTable? = nil,
         symbols: [String : TDXSymbol] = [String: TDXSymbol]()) {
        self.name = name
        self.level = level
        self.encloseingScope = encloseingScope
        self.symbols = symbols
    }
    
    func inser(_ symbol: TDXSymbol) {
        symbol.level = level
        ///以符号名称为键存入符号
        symbols[symbol.name] = symbol
    }
    
    func lookUp(_ key: String, inCurrentScrope: Bool = false) -> TDXSymbol? {
        ///在当前作用域查找符号
        if let ret = symbols[key] {
            return ret
        }
        ///如果仅查找当前作用域，在没有查到符号时返回nil
        if inCurrentScrope {
            return nil
        }
        
        ///如果当前作用域没有找到符号并且存在外层作用域
        if let up = encloseingScope {
            return up.lookUp(key, inCurrentScrope: inCurrentScrope)
        }
        
        return nil
    }
    
    func lookUpCache(_ key: String) -> TDXSymbol? {
        if TDXScopedSymbolTable.noCacheScope.contains(name) {
            return nil
        }
        
        
        if let ret = symbols[key] {
            return ret
        }
        
        return encloseingScope?.lookUpCache(key)
    }
    
    public func description() -> Any {
        return ["name": name,
                "level": level,
                "symbols": symbols]
    }
    
}
