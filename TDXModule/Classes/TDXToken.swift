//
//  TDXToken.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

public enum TDXTokenType: String {
 
    ///算数操作符
    case plus = "+"
    case minus = "-"
    case mul = "*"
    case div = "/"
    
    ///逻辑操作符
    case equal = "="
    case less = "<"
    case greater = ">"
    case notEqual = "!="
    case lessEqual = "<="
    case greaterEqual = ">="

    case lParen = "("
    case rParen = ")"
    case semi = ";"
    case comma = ","

    case and = "AND"
    case or = "OR"
    
    case id
//    case integer = "integer"
    case double = "double"
    case string = "string"

    ///赋值操作符
    case assign = ":="
    ///赋值绘制符
    case assignPlot = ":"
    
    case eof = "EOF"

    
}


public class TDXToken {
    
    ///类型
    let type: TDXTokenType
    ///值
    let value: String
    ///行
    let line: Int
    ///列
    let column: Int

    init(type: TDXTokenType, value: String, line: Int, column: Int) {
        self.type = type
        self.value = value
        self.line = line
        self.column = column
    }
    
    var key: String {
        String(line) + ":" + String(column)
    }
    
}
