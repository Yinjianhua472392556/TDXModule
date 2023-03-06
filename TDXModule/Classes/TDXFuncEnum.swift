//
//  TDXFuncEnum.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/2.
//

import Foundation

public enum TDXQuateFunc: String, CaseIterable {
    ///未知类型
    case unknown = "UNKNOWN"
    ///最高价
    case high = "HIGH"
    ///最高价
    case h = "H"
    ///最低价
    case low = "LOW"
    ///最低价
    case l = "L"
    ///收盘价
    case close = "CLOSE"
    ///收盘价
    case c = "C"
    ///成交量
    case vol = "VOL"
    ///成交量
    case v = "V"
    ///开盘价
    case open = "OPEN"
    ///开盘价
    case o = "O"
    ///上涨家数，函数仅对大盘有效
    case advance = "ADVANCE"
    ///下跌家数，函数仅对大盘有效
    case decline = "DECLINE"
    ///成交额
    case amount = "AMOUNT"
    ///分时图均价
    case zstjj = "ZSTJJ"
    
    public static func type(_ name: String) -> TDXQuateFunc {
        return TDXQuateFunc(rawValue: name) ?? .unknown
    }
    
    static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
    
}

public enum TDXDynamicFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///动态行情函数
//    case dynainfo = "DYNAINFO"
    ///流通股本
    case capital = "CAPITAL"
    
    public static func type(_ name: String) -> TDXDynamicFunc {
        return TDXDynamicFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
    
}


public enum TDXTimeFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///上穿 两条线交叉 后穿
    case period = "PERIOD"
    ///维持一定周期后上穿 两条线维持一定周期后交叉
    case date = "DATE"
    ///连涨 返回是否连涨周期数
    case time = "TIME"
    ///连跌 返回是否连跌周期
    case time2 = "TIME2"
    ///连大 返回是否持续存在X>Y。
    case year = "YEAR"
    ///存在 是否存在
    case month = "MONTH"
    ///一直存在
    case weekofyear = "WEEKOFYEAR"
    ///LAST 持续存在
    case weekday = "WEEKDAY"
    case daystotoday = "DAYSTOTODAY"
    case day = "DAY"
    case hour = "HOUR"
    case minute = "MINUTE"
    case fromopen = "FROMOPEN"
    
    
    public static func type(_ name: String) -> TDXTimeFunc {
        return TDXTimeFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
    
}


///线形
@objc public enum TDXDrawLineShapeFunc: Int, CaseIterable {
    
    ///默认线条 简单的折线图
//    case defaultLine = 1
    case none = 0

    
    ///空心圆点
    case stick = 1
    
    ///彩色柱状线
    case colorStick
    
    ///彩色柱状线
    ///成交量柱状线，当股价上涨时显示红色空心柱，则显示绿色实心柱
    case volStick
    
    ///状线和指标线
    case lineStick
    
    
    ///小交叉线 "x"状
    case crossDot
    
    
    ///正方形实心点(虽然变量名是circle 但是实际上画出来的是正方形点)
    case circleDot
    
    ///小圆点线
    case pointDot
    
    var name: String {
        switch self {
            
        case .none:
            return "none"
        case .stick:
            return "STICK"
        case .colorStick:
            return "COLORSTICK"
        case .volStick:
            return "VOLSTICK"
        case .lineStick:
            return "LINESTICK"
        case .crossDot:
            return "CROSSDOT"
        case .circleDot:
            return "CIRCLEDOT"
        case .pointDot:
            return "POINTDOT"
        }
    }
    
    ///默认形状
    public static var defaultValue: TDXDrawLineShapeFunc {
        return .none
    }
    
    public static func shape(_ name: String) -> TDXDrawLineShapeFunc {
        return TDXDrawLineShapeFunc.allCases.first(where: {$0.name == name}) ?? defaultValue
    }
    
    public static let allNames = allCases.filter({$0 != .none}).map({$0.name})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}

public enum TDXRefFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///最高值
    case hhv = "HHV"
    ///上一高点到当前的周期数
    case hhvbars = "HHVBARS"
    case llvbars = "LLVBARS"
    
    case ma = "MA"
    

    ///总和
    case sum = "SUM"
    
    
    
    case sumBars = "SUMBARS"
    
    ///向前引用
    case ref = "REF"
    
    case reverse = "REVERSE"
    
    case const = "CONST"
    
    case llv = "LLV"
    
    case drawnull =  "DRAWNULL"
    
    case barsSince =  "BARSSINCE"
    case barsLast =  "BARSLAST"
    case barsLasts = "BARSLASTS"
    case barsCount = "BARSCOUNT"
    case barsLastCount = "BARSLASTCOUNT"
    
    case currBarsCount = "CURRBARSCOUNT"
    
    case totalBarsCount = "TOTALBARSCOUNT"
    
    case mema = "MEMA"
    
    case sma = "SMA"
    case ema = "EMA"
    case expmema = "EXPMEMA"

    case dma = "DMA"

    
    
    case range = "RANGE"
    ///统计满足周期条件数
    case count = "COUNT"
    
    
    case refDate = "REFDATE"
    ///平均绝对偏差
    case avedev = "AVEDEV"
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}

///是否画线
public enum TDXDrawLineFunc: String, CaseIterable {

    case unknown = "UNKNOWN"
    
    case noDraw = "NODRAW"
    
    public static func value(_ name: String) -> TDXDrawLineFunc {
        return TDXDrawLineFunc(rawValue: name) ?? .unknown
    }
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}

public enum TDXIndexFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///大盘收盘价
    case indexC = "INDEXC"
    
    public static func type(_ name: String) -> TDXIndexFunc {
        return TDXIndexFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
    
}


public enum TDXLogicFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///上穿 两条线交叉 后穿
    case cross = "CROSS"
    ///维持一定周期后上穿 两条线维持一定周期后交叉
    case longcross = "LONGCROSS"
    ///连涨 返回是否连涨周期数
    case upnday = "UPNDAY"
    ///连跌 返回是否连跌周期
    case downnday = "DOWNNDAY"
    ///连大 返回是否持续存在X>Y。
    case nday = "NDAY"
    ///存在 是否存在
    case exist = "EXIST"
    ///一直存在
    case every = "EVERY"
    ///LAST 持续存在
    case last = "LAST"
    
    public static func type(_ name: String) -> TDXLogicFunc {
        return TDXLogicFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}


///线的颜色
public enum TDXDrawLineColorFunc: String, CaseIterable {
    
    case black = "COLORBLACK"
    case blue = "COLORBLUE"
    case green = "COLORGREEN"
    case cyan = "COLORCYAN"
    case red = "COLORRED"
    ///洋红色
    case magenta = "COLORMAGENTA"
    case brown = "COLORBROWN"
    case gray = "COLORGRAY"
    case yellow = "COLORYELLOW"
    case white = "COLORWHITE"
    ///淡灰色
    case ligray = "COLORLIGRAY"
    ///淡蓝色
    case liblue = "COLORLIBLUE"
    ///淡绿色
    case ligreen = "COLORLIGREEN"
    ///淡青色
    case licyan = "COLORLICYAN"
    ///淡红色
    case lired = "COLORLIRED"
    ///淡洋红色
    case limagenta = "COLORLIMAGENTA"
    
    
    public static let allNames = allCases.map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        let upper = name.uppercased()
        if allNames.contains(upper) {
           return true
        }
        let reg = "^COLOR[0-9A-Fa-f]{6}$"
        let pre = NSPredicate(format: "SELF MATCHES %@", reg)
        let res = pre.evaluate(with: upper)
        return res
    }
    
    ///默认颜色
    public static var defaultColor: UIColor {
//        return .green
        return .black
    }
    
    public static func color(with name: String) -> UIColor {
        let upper = name.uppercased()
        if let type = TDXDrawLineColorFunc(rawValue: upper) {
            switch type {
            case .black:
                return .black
            case .blue:
                return .blue
            case .green:
                return .green
            case .cyan:
                return .cyan
            case .red:
                return .red
            case .magenta:
                return .magenta
            case .brown:
                return .brown
            case .gray:
                return .gray
            case .yellow:
                return .yellow
            case .white:
                return .white
            case .ligray:
                return .lightGray
            case .liblue:
                return .blue
            case .ligreen:
                return .green
            case .licyan:
                return .cyan
            case .lired:
                return .red
            case .limagenta:
                return .magenta
            }
        }else {
            let slice = upper.replacingOccurrences(of: "COLOR", with: "")
            return defaultColor
        }
    }
}


///线厚
@objc public enum TDXDrawLineThickFunc: Int, CaseIterable {
    
    
    case defaultLineThick = -1

        
    ///线厚
    case lineThick = 0
    case lineThick0
    case lineThick1
    case lineThick2
    case lineThick3
    case lineThick4
    case lineThick5
    case lineThick6
    case lineThick7
    case lineThick8
    case lineThick9
    
    var name: String {
        switch self {
        case .defaultLineThick:
            return "defaultLineThick"
        case .lineThick:
            return "LINETHICK"
        case .lineThick0:
            return "LINETHICK0"
        case .lineThick1:
            return "LINETHICK1"
        case .lineThick2:
            return "LINETHICK2"
        case .lineThick3:
            return "LINETHICK3"
        case .lineThick4:
            return "LINETHICK4"
        case .lineThick5:
            return "LINETHICK5"
        case .lineThick6:
            return "LINETHICK6"
        case .lineThick7:
            return "LINETHICK7"
        case .lineThick8:
            return "LINETHICK8"
        case .lineThick9:
            return "LINETHICK9"
        }
    }
    
    public var width: Int {
        return max(0, (rawValue - 1))
    }
    
//
//    public var defaultWidth: Float {
//        return 0.5
//    }

    
    ///默认线厚
    public static var defaultValue: TDXDrawLineThickFunc {
//        return .lineThick1
        return .defaultLineThick
    }
    
    
    
    public static func thick(_ name: String) -> TDXDrawLineThickFunc {
        return TDXDrawLineThickFunc.allCases.first(where: {$0.name == name}) ?? defaultValue
    }
    
    public static let allNames = allCases.filter({$0 != .defaultLineThick}).map({$0.name})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}

public enum TDXArithmeticFunc: String, CaseIterable {
    ///未知类型
    case unknown = "UNKNOWN"
    ///逻辑非
    case not = "NOT"
    ///逻辑判断
    case `if` = "IF"
    ///逻辑判断
    case iff = "IFF"
    ///逻辑判断
    case ifn = "IFN"
    ///最大值
    case max = "MAX"
    ///最小值
    case min = "MIN"
    
    public static func type(_ name: String) -> TDXArithmeticFunc {
        return TDXArithmeticFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}


@objc public enum TDXDrawFunc: Int, CaseIterable {
    ///未知类型
    case unknown
    ///折线段
    case ployline
    ///直线段
    case line
    ///绘制K线
    case kine
    ///绘制柱线
    case stickline
    ///绘制图标
    case icon
    ///显示文字
    case text
    
    public var name: String {
        switch self {
        case .unknown:
            return "UNKNOWN"
        case .ployline:
            return "PLOYLINE"
        case .line:
            return "DRAWLINE"
        case .kine:
            return "DRAWKLINE"
        case .stickline:
            return "STICKLINE"
        case .icon:
            return "DRAWICON"
        case .text:
            return "DRAWTEXT"
        }
        
    }
    
    public static func type(_ name: String) -> TDXDrawFunc {
        return TDXDrawFunc.allCases.first(where: {$0.name == name}) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.name})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}


public enum TDXMathFunc: String, CaseIterable {
    case unknow = "UNKNOWN"
    /// 反余弦
    case acos = "ACOS"
    /// 反正弦
    case asin = "ASIN"
    /// 反正切
    case atan = "ATAN"
    /// 余弦
    case cos = "COS"
    /// 正弦
    case sin = "SIN"
    /// 正切
    case tan = "TAN"
    /// 指数
    case exp = "EXP"
    ///自然对数
    case ln = "LN"
    ///对数
    case log = "LOG"
    ///平方根
    case sqrt = "SQRT"
    ///
    case abs = "ABS"
    ///
    case pow = "POW"
    ///
    case ceiling = "CEILING"
    ///
    case floor = "FLOOR"
    ///
    case intpart = "INTPART"
    ///
    case between = "BETWEEN"

    public static func type(_ name: String) -> TDXMathFunc {
        return TDXMathFunc(rawValue: name) ?? .unknow
    }
    
    public static let allNames = allCases.filter({$0 != .unknow}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
}


public enum TDXStatisticsFunc: String, CaseIterable {
    
    ///未知类型
    case unknown = "UNKNOWN"
    ///板块股票个数
    case blocksetnum = "BLOCKSETNUM"
    ///多股统计
    case horcalc = "HORCALC"
    ///估算样本方差
    case varFunc = "VAR"
    
    public static func type(_ name: String) -> TDXStatisticsFunc {
        return TDXStatisticsFunc(rawValue: name) ?? .unknown
    }
    
    public static let allNames = allCases.filter({$0 != .unknown}).map({$0.rawValue})
    public static func contains(_ name: String) -> Bool {
        return allNames.contains(name)
    }
    
}
