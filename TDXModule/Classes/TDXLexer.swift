//
//  TDXLexer.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation


/**
 词法分析器
 */
@objcMembers
public class TDXLexer: NSObject {
    public var errorCallback: ((String) -> Void)?

    var text: String = ""
    ///字符位置
    var currentIndex: Int = -1
    ///当前字符
    var currentString: String = ""
    ///行
    var line: Int = 1
    ///列
    var column: Int = 0
    ///
    private let noneString = "None"

    public override init() {
        super.init()
    }
    
    public convenience init(text: String) {
        self.init()
        self.text = text
    }
}


public extension TDXLexer {
    
    func advance() {
        ///换行
        if self.currentString == "\n" {
            line = line + 1
            column = 0
        }
        ///获取字符的位置自增
        currentIndex += 1
        
        ///如果位置到达字符串的末尾
        if currentIndex >= text.count {
            ///设置当前字符为空值
            currentString = noneString
        }else {
            ///设置当前字符为指定位置的字符
            currentString = text.slicing(from: currentIndex, length: 1) ?? ""
            column += 1
        }
    }

    ///跳过空格
    func skipBlank() {
        ///如果当前字符不是None值并且当前字符是空格
        while currentString != noneString, currentString.isBlank {
            ///获取下一个字符
            advance()
        }
    }

    ///获取指定偏移量的字符
    func peek(_ offset: Int = 1) -> String {
        ///获取下一个位置
        let nextIndex = currentIndex + offset
        ///如果超出文本末端
        if nextIndex >= text.count {
            ///返回None
            return noneString
        }else {
            return text.slicing(from: nextIndex, length: 1) ?? ""
        }
    }

    func nextToken() -> TDXToken {
        ///如果当前字符不是None值
        while currentString != noneString {
            ///如果当前字符是空格
            if currentString.isBlank {
                ///跳过所有空格
                skipBlank()
                ///继续循环
                continue
            }
            ///如果当前字符是整数
            if currentString.isDigits {
                ///获取完整的数字创建记号对象并返回
                return number()
            }
            ///如果当前字符是字母/数字/汉字
            if currentString.isVar {
                
                if currentString.uppercased() == "A", peek().uppercased() == "N", peek(2).uppercased() == "D" {
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .and, value: TDXTokenType.and.rawValue, line: line, column: column)
                }
                
                if currentString.uppercased() == "O", peek().uppercased() == "R" {
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .or, value: TDXTokenType.or.rawValue, line: line, column: column)
                }
                ///调用方法返回保留字或赋值名称的记号
                return id()
            }
            ///如果当前字符是字符串开头
            if currentString == "\'" {
                return string()
            }
            ///如果当前字符是“:”，并且下一个字符是“=”
            if currentString == ":" {
                
                if peek() == "=" {
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .assign, value: TDXTokenType.assign.rawValue, line: line, column: column)
                }else {
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .assignPlot, value: TDXTokenType.assignPlot.rawValue, line: line, column: column)
                }

            }
            ///如果当前字符是“<”，并且下一个字符是“=”
            if currentString == "<" {
                if peek() == "=" {
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .lessEqual, value: TDXTokenType.lessEqual.rawValue, line: line, column: column)
                }else {
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .less, value: TDXTokenType.less.rawValue, line: line, column: column)
                }
            }
            ///如果当前字符是“>”
            if currentString == ">" {
                ///并且下一个字符是“=”
                if peek() == "=" {
                    ///提取下一个字符
                    advance()
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .greaterEqual, value: TDXTokenType.greaterEqual.rawValue, line: line, column: column)
                }else {
                    ///提取下一个字符
                    advance()
                    ///返回赋值符的记号
                    return TDXToken(type: .greater, value: TDXTokenType.greater.rawValue, line: line, column: column)
                }
            }
            
            ///更加字符串值直接转 TDXTokenType
            if let t = TDXTokenType(rawValue: currentString) {
                ///创建赋值符的记号
                let token = TDXToken(type: t, value: t.rawValue, line: line, column: column)
                ///提取下一个字符
                advance()
                ///返回赋值符的记号
                return token
            }
            
            advance()
            ///如果以上都不是，则抛出异常
            throwError(TDXLexError.unexpectedToken(name: currentString, line: line, column: column))
            
        }
        
        ///遍历结束返回结束标识创建的记号对象
        return TDXToken(type: .eof, value: noneString, line: line, column: column)
    }
}


extension TDXLexer {
    
    ///获取保留字或赋值名称记号的方法
    func id() -> TDXToken {
        
        var result = ""
        ///如果当前字符不是None值并且当前字符是字母/数字/汉字
        while currentString != noneString, currentString.isVar {
            ///连接字符
            result = result + currentString
            ///获取下一个字符
            advance()
        }
        ///如果有保留字，记得保留字相关逻辑
        ///返回ID记号
        let token = TDXToken(type: .id, value: result, line: line, column: column)
        
        return token
    }
    
    
    ///获取数字
    func number() -> TDXToken {
        
        var result = ""
        
        ///如果当前字符不是None值并且当前字符是数字
        while currentString != noneString, (currentString.isDigits || currentString == ".") {
            ///连接数字
            result = result + currentString
            ///获取下一个字符
            advance()
        }
        
        ///暂时统一用Double处理
        return TDXToken(type: .double, value: result, line: line, column: column)
        
    }

    ///获取字符串
    func string() -> TDXToken {
        
        var result = ""

        ///如果当前字符不是None值
        while currentString != noneString {
            ///连接字符
            result = result + currentString
            ///获取下一个字符
            advance()
            ///字符串结束
            if currentString == "\'" { break }
        }
        ///跳过字符串结束符号
        advance()
        ///跳过字符串开始符号
        result.slice(from: 1, length: result.count-1)
        
        return TDXToken(type: .string, value: result, line: line, column: column)
    }
    
}

extension TDXLexer {
    
    func throwError(_ error: TDXLexError) {
        debugPrint(error.description)
        errorCallback?(error.description)
    }
}
