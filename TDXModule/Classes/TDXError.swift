//
//  TDXError.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

public enum TDXLexError: Error {
    
    case unexpectedToken(name: String, line: Int, column: Int)
    
    var description: String {
        var desc = ""
        
        switch self {
        case .unexpectedToken(let name, let line, let column):
            desc = "未识别到的Token: \(name) : line: \(line)，column: \(column)"
        }
        return "❗️❗️❗️ERROR: 词法解析报错: " + desc
    }
    
}


enum TDXParseError: Error {
    
    case unmatchedTokenType(name: String)
    case errorExpression(name: String, line: Int, column: Int)
    
    var description: String {
        var desc = ""
        switch self {
        case .unmatchedTokenType(let name):
            desc = "Token类型不匹配: \(name) "
        case .errorExpression(let name, let line, let column):
            desc = "错误的语句: \(name) : line: \(line)，column: \(column)"
        }
        return "❗️❗️❗️ERROR: 语法解析报错: " + desc
    }
    
}

public enum TDXInterpretError: Error {
    
    case opFailed(name: String)
    case opRecognizeFailed(name: String)
    case opZeroDivisor(name: String)
    case getVarFailed(name: String, line: Int, column: Int)
    case getTopARFailed(name: String)
    
    var description: String {
        var desc = ""
        switch self {
        case .opFailed(let name):
            desc = "操作符执行失败: \(name)"
        case .opRecognizeFailed(let name):
            desc = "操作符识别失败: \(name)"
        case .opZeroDivisor(let name):
            desc = "除数为0: \(name)"
        case .getVarFailed(let name, let line, let column):
            desc = "变量获取失败: \(name) : line: \(line)，column: \(column)"
        case .getTopARFailed(let name):
            desc = "栈顶活动获取失败: \(name)"
        }
        return "❗️❗️❗️ERROR: 解释器报错: " + desc
    }
    
    public func throwError() {
//        debugPrint(description)
    }
}


public enum TDXFuncError: Error {
    
    case unexpectedFunc(name: String)
    case getParamFailed(name: String)
    case getQuateDataFailed(name: String)
    case getLogicFailed(name: String)
    case getTimeFailed(name: String)
    
    var description: String {
        var desc = ""
        switch self {
        case .unexpectedFunc(let name):
            desc = "未识别到函数: \(name)"
        case .getParamFailed(let name):
            desc = "参数获取失败: \(name)"
        case .getQuateDataFailed(let name):
            desc = "行情函数获取数据失败: \(name)"
        case .getLogicFailed(let name):
            desc = "逻辑函数获取数据失败: \(name)"
        case .getTimeFailed(let name):
            desc = "时间函数获取数据失败：\(name)"
        }
        return "❗️❗️❗️ERROR: 函数处理报错: " + desc
    }
    
    
    public func throwError() {
//        debugPrint(description)
    }

}
