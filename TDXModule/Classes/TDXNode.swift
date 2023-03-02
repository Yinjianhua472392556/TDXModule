//
//  TDXNode.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

@objcMembers
public class TDXNode: NSObject {
    let token: TDXToken
    var key: String = ""
    
    init(token: TDXToken) {
        self.token = token
    }
}

public class TDXStringNode: TDXNode {
    
    let value: String
    
    override init(token: TDXToken) {
        self.value = token.value
        super.init(token: token)
    }
}

public class TDXDoubleNode: TDXNode {
    
    let value: Double
    
    override init(token: TDXToken) {
        self.value = Double(token.value) ?? 0
        super.init(token: token)
    }
}

public class TDXBinaryOpNode: TDXNode {
    
    let left: TDXNode
    let op: TDXToken
    let right: TDXNode
    
    init(left: TDXNode, op: TDXToken, right: TDXNode) {
        self.left = left
        self.op = op
        self.right = right
        super.init(token: op)
    }
}

public class TDXUnaryOpNode: TDXNode {
    
    let op: TDXToken
    let exp: TDXNode
    
    init(op: TDXToken, exp: TDXNode) {
        self.op = op
        self.exp = exp
        super.init(token: op)
    }
    
}

///复合语句节点
public class TDXCompoundNode: TDXNode {
    ///子节点列表
    let children: [TDXNode]
    
    init(token: TDXToken, children: [TDXNode]) {
        self.children = children
        super.init(token: token)
    }
}

///语句节点
public class TDXStatementNode: TDXNode {
    ///子节点列表
    let children: [TDXNode]
    
    init(token: TDXToken, children: [TDXNode]) {
        self.children = children
        super.init(token: token)
    }
}

///赋值语句节点
public class TDXAssignNode: TDXNode {
    ///变量节点
    let left: TDXVariableNode
    ///右侧表达式
    let right: TDXNode
    
    init(left: TDXVariableNode, token: TDXToken, right: TDXNode) {
        self.left = left
        self.right = right
        super.init(token: token)
    }
}

///赋值绘图语句节点
public class TDXAssignPlotNode: TDXNode {
    ///变量节点
    let left: TDXVariableNode
    ///右侧表达式
    let right: TDXNode
    
    init(left: TDXVariableNode, token: TDXToken, right: TDXNode) {
        self.left = left
        self.right = right
        super.init(token: token)
    }
}

///变量节点
public class TDXVariableNode: TDXNode {
    ///变量值
    let name: String
    
    override init(token: TDXToken) {
        self.name = token.value
        super.init(token: token)
    }
}

///空语句节点
public class TDXEmptyNode: TDXNode {
    
}


///参数节点
public class TDXCallNode: TDXNode {
    ///过程名称
    let name: String
    ///过程实参列表
    let params: [TDXNode]
        
    init(params: [TDXNode], token: TDXToken) {
        self.name = token.value
        self.params = params
        super.init(token: token)
    }
    
}

