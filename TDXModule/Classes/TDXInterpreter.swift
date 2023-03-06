//
//  TDXInterpreter.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation


///线形
@objc public enum TDXDrawType: Int, CaseIterable {
    ///主图叠加
    case mainOverlay = 1
    ///副图
    case vice
    ///副图(叠加K线)
    case viceWithKline
}


/**
 解释器
 */

@objcMembers
public class TDXInterpreter: TDXNodeVisitor {
 
    static let varFuncNames: [String] = TDXQuateFunc.allNames + TDXDynamicFunc.allNames + TDXTimeFunc.allNames + [TDXRefFunc.drawnull.rawValue] + TDXDrawLineFunc.allNames + TDXIndexFunc.allNames
    
    ///AST解析树
    public let tree: TDXNode
    ///K线数据或者分时数据
    public let data: TDXDrawData
    ///遍历时数据下标
    public var index: Int = -1
    ///id用于后续区分指标
    public var id: Int = -1
    
    ///用于后续区分指标画线方式
    public var drawType: TDXDrawType = .mainOverlay
    ///预加载数据
    public var jobData: TDXJobData?
    
    ///当前作用域
    var currentScope: TDXScopedSymbolTable?

    lazy var calendar: Calendar = {
        return Calendar.current
    }()
    
    public init(tree: TDXNode,
                data: TDXDrawData) {
        self.tree = tree
        self.data = data
        super.init()
    }

    public init(tree: TDXNode,
         data: TDXDrawData,
         index: Int = TDXInvalidInt,
         id: Int = TDXInvalidInt,
         drawType: TDXDrawType,
         jobData: TDXJobData? = nil) {
        self.tree = tree
        self.data = data
        self.index = index
        self.id = id
        self.drawType = drawType
        self.jobData = jobData
        super.init()
    }
    
    
    func interpret() -> Any {
        var datas = [Any]()
        if isInvalidInt(index) {
            
            for (idx, d) in data.enumerated() {
                autoreleasepool {
                    let interpreter = TDXInterpreter(tree: tree, data: data, index: idx, drawType: drawType, jobData: jobData)
                    let res = interpreter.singleInterpret()
                    ///处理每一条K线及AST节点
                    handleData(d, res: res)
                    datas.append(res)
                }
            }
            
        }else {
            
            let interpreter = TDXInterpreter(tree: tree, data: data, index: index, drawType: drawType, jobData: jobData)
            let res = interpreter.singleInterpret()
            if let d = data[safe: index] {
                handleData(d, res: res)
            }
            datas.append(res)

        }
        
        return datas
    }
    
    
    
    func handleData(_ data: Any, res: Any) {
        
        var defaultDraws = [TDXDrawDefaultLine]()
        var textDraws = [TDXDrawText]()
        var ploylineDraws = [TDXDrawPloyline]()
        var klineDraws = [TDXDrawKine]()
        var sticklineDraws = [TDXDrawStickline]()
        var iconDraws = [TDXDrawIcon]()
        
        if let r = res as? [Any] {
            for item in r {
                if let i = item as? TDXDrawDefaultLine {
                    defaultDraws.append(i)
                }else if let i = item as? TDXDrawText {
                    textDraws.append(i)
                }else if let i = item as? TDXDrawPloyline {
                    ploylineDraws.append(i)
                }else if let i = item as? TDXDrawKine {
                    klineDraws.append(i)
                }else if let i = item as? TDXDrawStickline {
                    sticklineDraws.append(i)
                }else if let i = item as? TDXDrawIcon {
                    iconDraws.append(i)
                }
            }
        }

        ///目前是以 指标id + 冒号 + 画线方式 为 key, 例如：1:1
//        let key = String(id) + ":" + String(drawType.rawValue)
//        if let k = data as? DYKLine {
//            if var d = k.tdxDefaultLineDraws {
//                d[key] = defaultDraws
//            }else {
//                k.tdxDefaultLineDraws = [key: defaultDraws]
//            }
//            if var d = k.tdxTextDraws {
//                d[key] = textDraws
//            }else {
//                k.tdxTextDraws = [key: textDraws]
//            }
//            if var d = k.tdxPloylineDraws {
//                d[key] = ploylineDraws
//            }else {
//                k.tdxPloylineDraws = [key: ploylineDraws]
//            }
//            if var d = k.tdxKlineDraws {
//                d[key] = klineDraws
//            }else {
//                k.tdxKlineDraws = [key: klineDraws]
//            }
//            if var d = k.tdxSticklineDraws {
//                d[key] = sticklineDraws
//            }else {
//                k.tdxSticklineDraws = [key: sticklineDraws]
//            }
//            if var d = k.tdxIconDraws {
//                d[key] = iconDraws
//            }else {
//                k.tdxIconDraws = [key: iconDraws]
//            }
//        }else if let m = data as? DYRtmin {
//            if var d = m.tdxDefaultLineDraws {
//                d[key] = defaultDraws
//            }else {
//                m.tdxDefaultLineDraws = [key: defaultDraws]
//            }
//            if var d = m.tdxTextDraws {
//                d[key] = textDraws
//            }else {
//                m.tdxTextDraws = [key: textDraws]
//            }
//            if var d = m.tdxPloylineDraws {
//                d[key] = ploylineDraws
//            }else {
//                m.tdxPloylineDraws = [key: ploylineDraws]
//            }
//            if var d = m.tdxKlineDraws {
//                d[key] = klineDraws
//            }else {
//                m.tdxKlineDraws = [key: klineDraws]
//            }
//            if var d = m.tdxSticklineDraws {
//                d[key] = sticklineDraws
//            }else {
//                m.tdxSticklineDraws = [key: sticklineDraws]
//            }
//            if var d = m.tdxIconDraws {
//                d[key] = iconDraws
//            }else {
//                m.tdxIconDraws = [key: iconDraws]
//            }
//        }

    }
    
    func singleInterpret() -> Any {
        return genericVisit(tree)
    }
    
    //MARK: Visit Node
    override func stringVisit(_ node: TDXStringNode) -> Any {
        return node.value
    }

    override func doubleVisit(_ node: TDXDoubleNode) -> Any {
        return node.value
    }

    override func binaryVisit(_ node: TDXBinaryOpNode) -> Any {
        let op = node.op
        switch op.type {
        case .plus:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return l + r
            }
            TDXInterpretError.opFailed(name: op.type.rawValue).throwError()
            return TDXInvalidReturn
        case .minus:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return l - r
            }
            TDXInterpretError.opFailed(name: op.type.rawValue).throwError()
            return TDXInvalidReturn
        case .mul:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return l * r
            }
            TDXInterpretError.opFailed(name: op.type.rawValue).throwError()
            return TDXInvalidReturn
        case .div:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                if r != 0 {
                    return l / r
                }else {
                    TDXInterpretError.opZeroDivisor(name: op.type.rawValue).throwError()
                    return TDXInvalidReturn
                }
            }
            TDXInterpretError.opFailed(name: op.type.rawValue).throwError()
            return TDXInvalidReturn
        case .equal:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l == r) ?? TDXInvalidReturn
            }
            if let l = asString(left), let r = asString(right) {
                return asNumber(l == r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .notEqual:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l != r) ?? TDXInvalidReturn
            }
            if let l = asString(left), let r = asString(right) {
                return asNumber(l != r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .less:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l < r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .lessEqual:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l <= r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .greater:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l > r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .greaterEqual:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            if let l = asNumber(left), let r = asNumber(right) {
                return asNumber(l >= r) ?? TDXInvalidReturn
            }
            return asNumber(false) ?? TDXInvalidReturn
        case .and:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            let l = asCondition(left)
            let r = asCondition(right)
            return l && r
        case .or:
            let left = genericVisit(node.left)
            let right = genericVisit(node.right)
            let l = asCondition(left)
            let r = asCondition(right)
            return l || r
        default:
            TDXInterpretError.opRecognizeFailed(name: op.type.rawValue).throwError()
            return TDXInvalidReturn
        }
    }
    
    override func unaryVisit(_ node: TDXUnaryOpNode) -> Any {
        let op = node.op.type
        switch op {
        case .plus:
            let exp = genericVisit(node.exp)
            if let d = asNumber(exp) {
                return +d
            }
            return exp
        case .minus:
            let exp = genericVisit(node.exp)
            if let d = asNumber(exp) {
                return -d
            }
            return exp
        default:
            TDXInterpretError.opRecognizeFailed(name: op.rawValue).throwError()
            return node
        }
    }

    override func assignVisit(_ node: TDXAssignNode) -> Any {
        let name = node.left.name
        ///避免变量命名与函数名重复导致死循环调用，原则上变量名不能与函数名重复
        if !TDXInterpreter.varFuncNames.contains(name) {
            let varSymbol = TDXVarSymbol(name: name, level: currentScope?.level ?? 1, type: TDXSymbolType.assignVar.rawValue)
            varSymbol.value = node.right
            currentScope?.inser(varSymbol)
        }
        return node
    }

    override func assignPlotVisit(_ node: TDXAssignPlotNode) -> Any {
        let name = node.left.name
        ///避免变量命名与函数名重复导致死循环调用，原则上变量名不能与函数名重复
        if !TDXInterpreter.varFuncNames.contains(name) {
            let varSymbol = TDXVarSymbol(name: name, level: currentScope?.level ?? 1, type: TDXSymbolType.assignPlotVar.rawValue)
            varSymbol.value = node.right
            currentScope?.inser(varSymbol)
        }
        return node
    }
    
    override func variableVisit(_ node: TDXVariableNode) -> Any {
        let name = node.name
        ///避免变量命名与函数名重复导致死循环调用，原则上变量名不能与函数名重复
        if TDXInterpreter.varFuncNames.contains(name) {
            return handleIdFunc(node) ?? TDXInvalidReturn
        }else {
            if let res = getVarValue(node) {
                return res
            }else if let res = handleIdFunc(node) {
                return res
            }
        }
        
        return TDXInvalidReturn

    }
    
    override func statementVisit(_ node: TDXStatementNode) -> Any {
        
        let map = node.children.map({ genericVisit($0 )})
        
        let res: Any
        
        let first = map.first
        if let f = asNumber(first) {
            let draw = TDXDrawDefaultLine(id: id,
                                          key: node.token.key,
                                          drawType: drawType,
                                          lineColor: lastColor(in: map),
                                          lineThick: lastThick(in: map),
                                          lineShape: lastShape(in: map), hasNoDraw: lastNoDraw(in: map))
            draw.price = f
            res = draw
        }else if let f = first as? TDXAssignPlotNode {
            let name = f.left.name
            let value = genericVisit(f.left)
            if let v = asNumber(value) {
                let draw = TDXDrawDefaultLine(id: id,
                                              key: node.token.key,
                                              drawType: drawType,
                                              lineColor: lastColor(in: map),
                                              lineThick: lastThick(in: map),
                                              lineShape: lastShape(in: map), hasNoDraw: lastNoDraw(in: map))
                draw.price = v
                draw.name = name
                res = draw
            }else if let v = value as? TDXDrawPloyline {
                v.name = name
                v.lineColor = lastColor(in: map)
                v.lineThick = lastThick(in: map)
                v.lineShape = lastShape(in: map)
                v.hasNoDraw = lastNoDraw(in: map)
                res = v
            }else if let v = value as? TDXDraw {
                ///如果语句后出现了NODRAW，则该TDXDraw函数不用绘制
                let noDraw = lastNoDraw(in: map)
                if noDraw {
                    res = TDXInvalidReturn
                }else {
                    v.lineColor = lastColor(in: map)
                    v.lineThick = lastThick(in: map)
                    v.lineShape = lastShape(in: map)
                    v.hasNoDraw = noDraw
                    res = v
                }
            }else {
                res = TDXInvalidReturn
            }
        }else if let f = first as? TDXDraw {
            ///如果语句后出现了NODRAW，则该TDXDraw函数不用绘制
            let noDraw = lastNoDraw(in: map)
            if noDraw {
                res = TDXInvalidReturn
            }else {
                f.lineColor = lastColor(in: map)
                f.lineThick = lastThick(in: map)
                f.lineShape = lastShape(in: map)
                f.hasNoDraw = noDraw
                res = f
            }
        }else {
            res = TDXInvalidReturn
        }
        
        return res
    }
    
    override func compoundVisit(_ node: TDXCompoundNode) -> Any {
        ///创建全局作用域符号表
        let globalScope = TDXScopedSymbolTable(name: "global", level: 1)
        
        ///缓存当前全局作用域
        jobData?.globalCache[index] = globalScope
        
        currentScope = globalScope
        
        ///将当前数据下标存入全局作用域
        saveDataIndex(index)
        
        ///遍历调用所有子节点
        let map = node.children.map({ genericVisit($0) })
        
        ///离开作用域时设置当前作用域为外围作用域
        currentScope = currentScope?.encloseingScope
        
        return map
    }
    
    override func callVisit(_ node: TDXCallNode) -> Any {
        let name = node.name
        let funcKey = node.key

        ///如果可以找到函数缓存值，则直接返回函数缓存值
        if let cacheValue = getFuncValue(node, key: funcKey) {
            return cacheValue
        }
        
        let idx = dataIndex()
        ///创建函数符号
        let symbol = TDXFuncSymbol(name: funcKey, level: currentScope?.level ?? 1, type: "")
        ///添加到当前作用域
        currentScope?.inser(symbol)
        ///同时缓存至jobData的全局作用域列表中
        inserGlobalCache(symbol, idx: idx)
        
        let hasScope = canCreateScope(with: name)
        ///创建作用域符号表
        if hasScope {
            let scope = TDXScopedSymbolTable(name: name, level: (currentScope?.level ?? 1) + 1, encloseingScope: currentScope)
            ///当前作用域设置为过程作用域
            currentScope = scope
            ///存入当前最新下标至当前作用域
            saveDataIndex(idx)
        }

        let res = handleFunc(node)
        
        ///缓存函数结果值
        symbol.cacheValue = res
        
        ///离开作用域时设置当前作用域为外围作用域
        if hasScope {
            currentScope = currentScope?.encloseingScope
        }

        return res

    }
    
}


extension TDXInterpreter {
    
    func canCreateScope(with name: String) -> Bool {
//        if TDXDrawFunc.contains(name) {
//            return false
//        }
        return true
    }
    
    func inserGlobalCache(_ symbol: TDXSymbol, idx: Int? = nil) {
        if let scope = jobData?.globalCache[idx ?? index] {
            scope.inser(symbol)
        }
    }
    
    func globalCache(_ key: String, idx: Int) -> TDXSymbol? {
        if let scope = jobData?.globalCache[idx],
           let symbol = scope.lookUp(key, inCurrentScrope: true) {
            return symbol
        }
        return nil
    }
    
    func getFuncValue(_ node: TDXCallNode, key: String) -> Any? {
        let idx = dataIndex()
        ///先去缓存的jobData的全局作用域列表中查找
        if let symbol = globalCache(key, idx: idx) as? TDXFuncSymbol, let cacheValue = symbol.cacheValue {
            return cacheValue
        }
        
        return nil
    }
    
    func getVarValue(_ node: TDXVariableNode) -> Any? {
        let name = node.name
        let idx = dataIndex()
        ///先去缓存的jobData的全局作用域列表中查找
        if let symbol = globalCache(name, idx: idx) as? TDXVarSymbol {
            if let cacheValue = symbol.cacheValue {
                return cacheValue
            }else if let n = symbol.value {
                let value = genericVisit(n)
                symbol.cacheValue = value
                return value
            }
        }
        if let symbol = currentScope?.lookUp(name, inCurrentScrope: false) as? TDXVarSymbol,
           let n = symbol.value {
            let value = genericVisit(n)
            symbol.cacheValue = value
            return value
        }
        return nil
    }
    
}


extension TDXInterpreter {
    
    func handleIdFunc(_ node: TDXVariableNode) -> Any? {
        let name = node.name
        if TDXQuateFunc.contains(name) {
            return handleQuote(name)
        }else if TDXDrawLineColorFunc.contains(name) {
            return TDXDrawLineColorFunc.color(with: name)
        }else if TDXDrawLineShapeFunc.contains(name) {
            return TDXDrawLineShapeFunc.shape(name)
        }else if TDXDrawLineThickFunc.contains(name) {
            return TDXDrawLineThickFunc.thick(name)
        }else if TDXTimeFunc.contains(name) {
            return handleTime(name)
        }else if TDXDynamicFunc.contains(name) {
            return handleDynamic(name)
        }else if TDXDrawLineFunc.contains(name) {
            return TDXDrawLineFunc.value(name)
        }else if TDXIndexFunc.contains(name) {
            return handleIndex(name)
        }else if name == TDXRefFunc.drawnull.rawValue {
            return drawnull()
        }
        return nil
    }
    
    func handleFunc(_ node: TDXCallNode) -> Any {
        let name = node.name
        let res: Any
        if TDXDrawFunc.contains(name) {
            res = handleDraw(node)
        }else if TDXRefFunc.contains(name) {
            res = handleRef(node)
        }else if TDXLogicFunc.contains(name) {
            res = handleLogic(node)
        }else if TDXArithmeticFunc.contains(name) {
            res = handleArithmetic(node)
        }else if TDXMathFunc.contains(name) {
            res = handleMath(node)
        }else if TDXStatisticsFunc.contains(name) {
            res = handleStatistics(node)
        }else {
            res = TDXInvalidReturn
        }
        return res
    }
}

extension TDXInterpreter {
    
    ///存储下标至当前作用域
    func saveDataIndex(_ index: Int) {
        ///创建Int类型符号
        if let symbol = currentScope?.lookUp("tdx_data_index", inCurrentScrope: true) as? TDXIntSymbol {
            symbol.value = index
            currentScope?.inser(symbol)
        }else {
            let symbol = TDXIntSymbol(name: "tdx_data_index", level: currentScope?.level ?? 1, type: "")
            symbol.value = index
            currentScope?.inser(symbol)
        }
    }
    
    ///获取最近作用域下的下标
    func dataIndex() -> Int {
        guard let symbol = currentScope?.lookUp("tdx_data_index", inCurrentScrope: false) as? TDXIntSymbol else { return index }
        return symbol.value ?? index
    }
    
}


extension TDXInterpreter {
    
    func lastColor(in map: [Any]) -> UIColor {
        guard let res = map.last(where: { $0 is UIColor }) as? UIColor else {
            return TDXDrawLineColorFunc.defaultColor
        }
        return res
    }
    
    func lastThick(in map: [Any]) -> Int {
        guard let res = map.last(where: { $0 is TDXDrawLineThickFunc }) as? TDXDrawLineThickFunc else {
            return TDXDrawLineThickFunc.defaultValue.width
        }
        return res.width
    }
    
    func lastShape(in map: [Any]) -> TDXDrawLineShapeFunc {
        guard let res = map.last(where: { $0 is TDXDrawLineShapeFunc }) as? TDXDrawLineShapeFunc else {
            return TDXDrawLineShapeFunc.defaultValue
        }
        return res
    }
    
    func lastNoDraw(in map: [Any]) -> Bool {
        guard let res = map.last(where: { $0 is TDXDrawLineFunc }) as? TDXDrawLineFunc else {
            return false
        }
        return res == .noDraw
    }
    
}
