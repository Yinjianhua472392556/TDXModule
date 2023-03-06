//
//  TDXNodeVisitor.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation


/**
 节点访问器
 */
public class TDXNodeVisitor: NSObject {
    
    @discardableResult
    func genericVisit(_ node: TDXNode) -> Any {
        if let n = node as? TDXVariableNode {
            return variableVisit(n)
        }else if let n = node as? TDXBinaryOpNode {
            return binaryVisit(n)
        }else if let n = node as? TDXCallNode {
            return callVisit(n)
        }else if let n = node as? TDXAssignNode {
            return assignVisit(n)
        }else if let n = node as? TDXAssignPlotNode {
            return assignPlotVisit(n)
        }else if let n = node as? TDXDoubleNode {
            return doubleVisit(n)
        }else if let n = node as? TDXUnaryOpNode {
            return unaryVisit(n)
        }else if let n = node as? TDXStatementNode {
            return statementVisit(n)
        }else if let n = node as? TDXStringNode {
            return stringVisit(n)
        }else if let n = node as? TDXCompoundNode {
            return compoundVisit(n)
        }else if let n = node as? TDXEmptyNode {
            return emptyVisit(n)
        }
        return node
    }
    
    @discardableResult
    func genericKey(_ node: TDXNode) -> String {
        if let n = node as? TDXStringNode {
            return n.token.value
        }else if let n = node as? TDXDoubleNode {
            return n.token.value
        }else if let n = node as? TDXBinaryOpNode {
            return genericKey(n.left) + " " + n.op.value + " " + genericKey(n.right)
        }else if let n = node as? TDXUnaryOpNode {
            return n.op.value + genericKey(n.exp)
        }else if let n = node as? TDXAssignNode {
            return n.left.name + n.token.value + genericKey(n.right)
        }else if let n = node as? TDXAssignPlotNode {
            return n.left.name + n.token.value + genericKey(n.right)
        }else if let n = node as? TDXVariableNode {
            return n.name
        }else if let n = node as? TDXStatementNode {
            return n.children.map({genericKey($0)}).joined(separator: ",")
        }else if let n = node as? TDXCompoundNode {
            return n.children.map({genericKey($0)}).joined(separator: ";")
        }else if let n = node as? TDXCallNode {
            let p = n.params.map({genericKey($0)}).joined(separator: ",")
            return n.name + "(" + p  + ")"
        }else if let _ = node as? TDXEmptyNode {
            return ""
        }
        return ""
    }
    
    func visit(_ node: TDXNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func stringVisit(_ node: TDXStringNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }

    func doubleVisit(_ node: TDXDoubleNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func binaryVisit(_ node: TDXBinaryOpNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func unaryVisit(_ node: TDXUnaryOpNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func assignVisit(_ node: TDXAssignNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func assignPlotVisit(_ node: TDXAssignPlotNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func variableVisit(_ node: TDXVariableNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func statementVisit(_ node: TDXStatementNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func compoundVisit(_ node: TDXCompoundNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func callVisit(_ node: TDXCallNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }
    
    func emptyVisit(_ node: TDXEmptyNode) -> Any {
//        debugPrint("\(self): \(node): Visit")
        return node
    }

}
