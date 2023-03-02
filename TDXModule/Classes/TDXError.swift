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
