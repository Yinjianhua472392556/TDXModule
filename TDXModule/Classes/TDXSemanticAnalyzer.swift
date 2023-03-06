//
//  TDXSemanticAnalyzer.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/6.
//

import Foundation

/**
 语义分析器
 */

@objcMembers
public class TDXSemanticAnalyzer: TDXNodeVisitor {
    
    public var errorCallback: ((String) -> Void)?
    
    ///当前作用域
    var currentScope: TDXScopedSymbolTable?
    
    public override init() {
        super.init()
    }

    override func doubleVisit(_ node: TDXDoubleNode) -> Any {
        return node
    }
    
    override func binaryVisit(_ node: TDXBinaryOpNode) -> Any {
        genericVisit(node.left)
        genericVisit(node.right)
        return node
    }
    
    override func unaryVisit(_ node: TDXUnaryOpNode) -> Any {
        return node
    }
    
    override func assignVisit(_ node: TDXAssignNode) -> Any {
        genericVisit(node.right)
        let varNode = node.left
        let name = varNode.name
        let varSymbol = TDXVarSymbol(name: name, level: currentScope?.level ?? 1, type: "")
        currentScope?.inser(varSymbol)
        return node
    }
    
    override func assignPlotVisit(_ node: TDXAssignPlotNode) -> Any {
        genericVisit(node.right)
        let varNode = node.left
        let name = varNode.name
        let varSymbol = TDXVarSymbol(name: name, level: currentScope?.level ?? 1, type: "")
        currentScope?.inser(varSymbol)
        return node
    }
    
    override func variableVisit(_ node: TDXVariableNode) -> Any {
        let name = node.name
        guard !TDXTimeFunc.contains(name) else {
            return node
        }
        guard !TDXQuateFunc.contains(name) else {
            return node
        }
        guard !TDXDrawLineThickFunc.contains(name) else {
            return node
        }
        guard !TDXDrawLineShapeFunc.contains(name) else {
            return node
        }
        guard !TDXDrawLineColorFunc.contains(name) else {
            return node
        }
        guard !TDXDrawLineFunc.contains(name) else {
            return node
        }
        let symbol = currentScope?.lookUp(name, inCurrentScrope: false)
        if symbol == nil {
            throwError(.unexpectedVar(name: name, line: node.token.line, column: node.token.column))
        }
        return node
    }

    override func compoundVisit(_ node: TDXCompoundNode) -> Any {
        ///创建全局作用域符号表
        let globalScope = TDXScopedSymbolTable(name: "global", level: 1)
        currentScope = globalScope
        debugPrint(">>> 进入全局作用域：global, level: \(globalScope.level)")
        ///遍历调用所有子节点
        node.children.forEach({ genericVisit($0) })
        ///打印作用域
        debugPrint(globalScope.description())
        ///离开作用域时设置当前作用域为外围作用域
        currentScope = self.currentScope?.encloseingScope
        debugPrint(">>> 离开全局作用域：global, level: \(globalScope.level)")
        return node
    }
    
    override func callVisit(_ node: TDXCallNode) -> Any {
        let name = node.name
        ///创建函数符号
        let symbol = TDXFuncSymbol(name: name, level: currentScope?.level ?? 1, type: "")
        ///添加到当前作用域
        currentScope?.inser(symbol)
        ///创建作用域符号表
        let scope = TDXScopedSymbolTable(name: name, level: (currentScope?.level ?? 1) + 1, encloseingScope: currentScope)
        ///当前作用域设置为过程作用域
        currentScope = scope
        debugPrint(">>> 进入函数作用域：\(name), level: \(scope.level)")
        ///遍历调用所有的参数列表
        node.params.forEach({ genericVisit($0) })
        
        if TDXDrawFunc.contains(name) {
            
        }else if TDXRefFunc.contains(name) {
            
        }else if TDXLogicFunc.contains(name) {
            
        }else if TDXArithmeticFunc.contains(name) {
            
        }else {
            throwError(.unexpectedFunc(name: node.name, line: node.token.line, column: node.token.column))
        }
        
        ///打印作用域
        debugPrint(scope.description())
        ///离开作用域时设置当前作用域为外围作用域
        currentScope = currentScope?.encloseingScope
        debugPrint(">>> 离开函数作用域：\(name), level: \(scope.level)")
        return node
    }
    
    override func emptyVisit(_ node: TDXEmptyNode) -> Any {
        return node
    }

}

extension TDXSemanticAnalyzer {
    
    func throwError(_ error: TDXSemanticAnalyzerError) {
        debugPrint(error.description)
        errorCallback?(error.description)
    }
    
}
