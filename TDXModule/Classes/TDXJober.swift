//
//  TDXJober.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation


public enum TDXJobType: String, CaseIterable {
    ///分时图均价
    case zstjj
    ///板块股票数量
    case blocksetnum
    
    public static func type(_ name: String) -> TDXJobType? {
        return TDXJobType(rawValue: name)
    }
    
    public static let allNames = allCases.map({$0.rawValue})
    
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}

@objcMembers
public class TDXJob: NSObject {
    let type: TDXJobType
    let key: String
    let call: TDXCallNode
    let line: Int
    let column: Int

    static func ==(lhs: TDXJob, rhs: TDXJob) -> Bool {
        return lhs.type == rhs.type && lhs.key == rhs.key
    }
    
    public init(type: TDXJobType, key: String, call: TDXCallNode, line: Int, column: Int) {
        self.type = type
        self.key = key
        self.call = call
        self.line = line
        self.column = column
    }
}


public class TDXJober: TDXInterpreter {
    
    ///K线数据
    public let klineData: TDXDrawData
    ///分时数据
    public let minData: TDXDrawData

    /**
     周期类型
     typedef GPB_ENUM(PeriodType) {
       PeriodType_Min1 = 1,
       PeriodType_Min3 = 2,
       PeriodType_Min5 = 3,
       PeriodType_Min15 = 4,
       PeriodType_Min30 = 5,
       PeriodType_Min60 = 6,
       PeriodType_Min120 = 7,
       PeriodType_Min180 = 8,
       PeriodType_Min240 = 9,
       PeriodType_Day = 10,
       PeriodType_Week = 11,
       PeriodType_Month = 12,
       PeriodType_Season = 13,
       PeriodType_HalfYear = 14,
       PeriodType_Year = 15,
     };
     */
    public let periodType: Int
    
    ///数据输出
    public var output = TDXJobData()
    
    ///任务列表
    private var jobs = [TDXJob]()
    
    /// 尽量用此方法初始化
    public init(tree: TDXNode, klines: TDXDrawData, mins: TDXDrawData, periodType: Int = 10) {
        self.klineData  = klines
        self.periodType = periodType
        self.minData    = mins
        super.init(tree: tree, data: klines)
    }
    
    func runJobs() -> TDXJobData {
        output.periodType = periodType
        genericKey(tree)
        createScope()
        genericVisit(tree)
        runNextJob()
        return output
    }

    @discardableResult
    public override func genericKey(_ node: TDXNode) -> String {
        let key = super.genericKey(node)
        node.key = key
        return key
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
            if let symbol = currentScope?.lookUp(name, inCurrentScrope: false) as? TDXVarSymbol,
               let n = symbol.value {
                let value = genericVisit(n)
                return value
            }else if let res = handleIdFunc(node) {
                return res
            }
        }
        return TDXInvalidReturn
    }

    override func compoundVisit(_ node: TDXCompoundNode) -> Any {
        let map = node.children.map({ genericVisit($0 )})
        return map
    }

    override func callVisit(_ node: TDXCallNode) -> Any {
        let key = node.key
        guard TDXJobType.contains(node.name) else {
            return node
        }
        guard let type = TDXJobType.type(node.name) else {
            return node
        }
        ///如果任务列表中还没有当前任务，则新建任务加入到列表中
        guard let _ = jobs.first(where: {$0.key == key}) else {
            let token = node.token
            let newJob = TDXJob(type: type, key: key, call: node, line: token.line, column: token.column)
            insert(newJob)
            return node
        }
        return node
    }
    
}

extension TDXJober {
    
    func createScope() {
        ///创建全局作用域符号表
        currentScope = TDXScopedSymbolTable(name: "global", level: 1)
        ///将当前数据下标存入全局作用域
        saveDataIndex(index)
    }
    
    func insert(_ job: TDXJob) {
        jobs.append(job)
    }
    
    func nextJob() -> TDXJob? {
        jobs = jobs.sorted(by: { $0.line > $1.line || ($0.line == $1.line && $0.column < $1.column) })
        return jobs.popLast()
    }
}

extension TDXJober {
    
    func runNextJob() {
        guard let job = nextJob() else { return }
        handle(job)
    }
    
    func handle(_ job: TDXJob) {
        ///重置当前作用域下标
        saveDataIndex(index)

        switch job.type {
        case .zstjj:
            output.zstjj = handleZstjj()
        case .blocksetnum:
            blockSetNum()
        }
    }
    
    func handleZstjj() -> Double {
//        let sum = minData.reduce(0.0) { partialResult, tmp in
//            guard let min = tmp as? DYRtmin else { return partialResult + 0.0 }
//            return partialResult + Double(min.close)
//        }
        let sum = 0
        
        return Double(sum) / Double(minData.count)
    }
    
    func blockSetNum() {
        // 板块的函数有问题，目前没有根据板块名获取板块信息的相关接口，做不了
        output.blockSetSum = 0
    }
    
}

@objcMembers
public class TDXJobData: NSObject {
    
    public var globalCache = [Int: TDXScopedSymbolTable]()

    ///大盘收盘价
    public var indexCData = [Double]()
    ///流通股本，单位：手
    public var capital: Double = 1
    ///分时图均价
    public var zstjj: Double = 0
    ///板块股票个数
    public var blockSetSum: Int?
    ///获取周期类型
    public var periodType: Int = 10
    ///连续满足条件的周期数 key为 node的key
    public var barsLastCountData = [String: [Double]]()
    ///平均绝对偏差 key为 node的key
    public var avedevData = [String: [Double]]()
    ///ema key为 node的key
    public var countData = [String: [Double]]()

    ///count函数计算结果
    public var countFuncResult = [TDXNode : Double]()
    
    
    public var refDateFuncResult = [TDXNode : Double]()

    
    
    public var barsCountFuncResult = [TDXNode : Double]()

    
    
    public var barsLastsFuncResult = [TDXNode : [Int : Double]]()

    public var barsLastFuncResult = [TDXNode : [Int : Double]]()
    public var barsSinceFuncResult = [TDXNode : Int]()

    
    public var hhvFuncResult = [TDXNode : [Int : Double]]()
    
    public var hhvBarsFuncResult = [TDXNode : [Int : Double]]()

    
    public var sumFuncResult = [TDXNode : [Int : Double]]()
    public var sumBarsFuncResult = [TDXNode : [Int : Double]]()

    
    public var maFuncResult = [TDXNode : [Int : Double]]()

//    public var emaFuncResult = [TDXNode : Double]()
    public var emaFuncResult = [TDXNode : [Int : Double]]()

//    public var memaFuncResult = [TDXNode : Double]()
    public var memaFuncResult = [TDXNode : [Int : Double]]()

//    public var smaFuncResult = [TDXNode : Double]()
    public var smaFuncResult = [TDXNode : [Int : Double]]()
    
    public var dmaFuncResult = [TDXNode : [Double]]()
//    public var dmaFuncResult = [TDXNode : [Int : Double]]()

    

    public var longCross = [TDXCallNode: [Int]]()
    public var upNDay = [TDXCallNode: [Int]]()
    public var nDay = [TDXCallNode: [Int]]()
    public var downNDay = [TDXCallNode: [Int]]()
    public var exist = [TDXCallNode: [Int]]()
    public var every = [TDXCallNode: [Int]]()
    public var last = [TDXCallNode: [Int]]()

    public override init() {}
    
}
