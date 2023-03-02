//
//  TDXParser.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

/**
 语法解析器
 */

public class TDXParser: NSObject {
    
    public var errorCallback: ((String) -> Void)?

    var lexer: TDXLexer = TDXLexer(text: "")
    var currentToken: TDXToken = TDXToken(type: .semi, value: ";", line: 0, column: 0)
    
    public override init() {
        super.init()
    }
    
    convenience init(lexer: TDXLexer) {
        self.init()
        ///语法分析器初始化
        self.lexer = lexer
        self.currentToken = self.lexer.nextToken()
    }
    
    func parse() -> TDXNode {
        return compoundStatement()
    }
}


extension TDXParser {
    
    func eat(_ tokenType: TDXTokenType) {
        if currentToken.type == tokenType {
            currentToken = lexer.nextToken()
        }else {
            
        }
    }
    
    ///语法分析器最底层结构
    func factor() -> TDXNode {
        let token = currentToken
        switch token.type {
        case .plus, .minus:
            eat(token.type)
            return TDXUnaryOpNode(op: token, exp: factor())
        case .double:
            eat(token.type)
            return TDXDoubleNode(token: token)
        case .string:
            eat(token.type)
            return TDXStringNode(token: token)
        case .lParen:
            eat(.lParen)
            let node = expr()
            eat(.rParen)
            return node
        case .id:
            ///过程或函数调用作为因子被引用
            if lexer.currentString == "(" {
                ///获取函数调用节点
                return callStatement()
            }else {
                return variable()
            }
        case .eof:
            return empty()
        default:
            ///变量作为因子被引用
            return variable()
        }
    }
    
    func term() -> TDXNode {
        var node = factor()
        while currentToken.type == .mul || currentToken.type == .div {
            let token = currentToken
            eat(token.type)
            ///生成新的树：把目前已经获取到的乘除法树整体做为左子树，起到连续乘除的作用
            node = TDXBinaryOpNode(left: node, op: token, right: factor())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
    }
    
    func plusOrMinus() -> TDXNode {
        var node = term()
        let first: [TDXTokenType] = [.plus, .minus]
        while first.contains(currentToken.type) {
            let token = currentToken
            eat(token.type)
            node = TDXBinaryOpNode(left: node, op: token, right: term())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
    }

    func logic() -> TDXNode {
        ///获取第一段乘除
        var node = plusOrMinus()
        let first: [TDXTokenType] = [.less, .lessEqual, .greater, .greaterEqual]
        while first.contains(currentToken.type) {
            let token = currentToken
            eat(token.type)
            node = TDXBinaryOpNode(left: node, op: token, right: plusOrMinus())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
    }

    func equalOrNotEqual() -> TDXNode {
        ///获取第一段乘除
        var node = logic()
        let first: [TDXTokenType] = [.equal, .notEqual]
        while first.contains(currentToken.type) {
            let token = currentToken
            eat(token.type)
            node = TDXBinaryOpNode(left: node, op: token, right: logic())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
        
    }

    func and() -> TDXNode {
        var node = equalOrNotEqual()
        while currentToken.type == .and {
            let token = currentToken
            eat(token.type)
            node = TDXBinaryOpNode(left: node, op: token, right: equalOrNotEqual())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
    }
    
    func or() -> TDXNode {
        var node = and()
        while currentToken.type == .or  {
            let token = currentToken
            eat(token.type)
            node = TDXBinaryOpNode(left: node, op: token, right: and())
        }
        ///新的树以取得新的数字或括号内的树为右子树
        return node
    }

    ///语法分析器最高层结构
    func expr() -> TDXNode {
        return or()
    }

}


extension TDXParser {
    
    ///获取空语句节点
    func empty() -> TDXEmptyNode {
        return TDXEmptyNode(token: currentToken)
    }
    
    ///获取变量节点
    func variable() -> TDXVariableNode {
        ///获取变量节点
        let node = TDXVariableNode(token: currentToken)
        ///验证变量名称
        eat(TDXTokenType.id)
        ///返回变量节点
        return node
    }
    
    ///获取赋值语句节点
    func assignStatement() -> TDXNode {
        ///获取变量名称节点
        let left = variable()
        ///获取当前记号
        let token = currentToken
        ///验证赋值符
        eat(.assign)
        ///获取右侧表达式
        let right = expr()
        ///创建赋值语句节点
        return TDXAssignNode(left: left, token: token, right: right)
    }
    
    ///获取赋值绘图语句节点
    func assignPlotStatement() -> TDXNode {
        ///获取变量名称节点
        let left = variable()
        ///获取当前记号
        let token = currentToken
        ///验证赋值符
        eat(.assignPlot)
        ///获取右侧表达式
        let right = expr()
        ///创建赋值语句节点
        return TDXAssignPlotNode(left: left, token: token, right: right)
    }

    ///获取语句节点
    func statement() -> TDXStatementNode {
        ///获取第一个语句元素节点
        let node = statementFactor()
        ///添加第一个语句元素到列表
        var nodes = [node]
        ///如果遇到逗号
        while currentToken.type == .comma {
            ///验证逗号
            eat(.comma)
            ///去除连续逗号
            if currentToken.type != .comma, currentToken.type != .semi {
                ///添加语句线节点
                nodes.append(statementLine())
            }
        }
        return TDXStatementNode(token: currentToken, children: nodes)
    }
    
    ///获取语句元素节点
    func statementFactor() -> TDXNode {
        let tokenType = currentToken.type
        switch tokenType {
        case .id:
            if lexer.currentString == "(" {
                return callStatement()
            }else if lexer.currentString == ":" {
                if lexer.peek() == "=" {
                    return assignStatement()
                }else {
                    return assignPlotStatement()
                }
            }else {
                return expr()
            }
        default:
            return expr()
        }
    }

    ///获取语句线节点
    func statementLine() -> TDXNode {
        let tokenType = currentToken.type
        switch tokenType {
        case .id:
            if lexer.currentString == "(" {
                return callStatement()
            }else {
                return expr()
            }
        default:
            return expr()
        }
    }

    ///获取语句列表节点
    func statementList() -> [TDXStatementNode] {
        ///获取第一条语句节点
        let node = statement()
        ///添加第一条语句节点到列表
        var nodes = [node]
        ///如果遇到分号
        while currentToken.type == .semi {
            ///验证分号
            eat(.semi)
            ///去除连续分号
            if currentToken.type != .semi {
                ///添加下一条语句节点到列表
                nodes.append(statement())
            }
        }
        ///如果只遇到一个名称而非语句
        if currentToken.type == .id {
            throwError(TDXParseError.errorExpression(name: currentToken.type.rawValue, line: currentToken.line, column: currentToken.column))
        }
        return nodes
    }
    
    func compoundStatement() -> TDXCompoundNode {
        let nodes = statementList()
        let node = TDXCompoundNode(token: currentToken, children: nodes)
        return node
    }

    ///函数调用节点
    func callStatement() -> TDXCallNode {
        let token = currentToken
        ///调用名称是一个ID类型的token
        eat(.id)
        ///解析左括号
        eat(.lParen)

        var params = [TDXNode]()
        
        
        if currentToken.type != .rParen {
            let node = expr()
            params.append(node)
        }
        
        while currentToken.type == .comma {
            eat(.comma)
            let node = expr()
            params.append(node)
        }
         
    
        eat(.rParen)
        
        return TDXCallNode(params: params, token: token)
    }
}


extension TDXParser {
    
    func throwError(_ error: TDXParseError) {
        debugPrint(error.description)
        errorCallback?(error.description)
    }
    
}
