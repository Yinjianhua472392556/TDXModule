//
//  TDXDraw.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation

public class TDXDraw: NSObject {
    ///用来区分是哪个指标
    public let id: Int
    ///用来区分是同一指标下哪个语句哪一行哪一列绘制
    ///目前是取 TDXToken 的 key 字段，即 line + 冒号 + column，例如：1:1
    public let key: String
    ///用来区分绘制方式
    public let drawType: TDXDrawType
    ///线色
    public var lineColor: UIColor
    ///线厚
    public var lineThick: Int
    ///不划线
    public var hasNoDraw: Bool
    
    ///线型
    public var lineShape: TDXDrawLineShapeFunc

    init(id: Int,
         key: String,
         drawType: TDXDrawType,
         lineColor: UIColor = TDXDrawLineColorFunc.defaultColor,
         lineThick: Int = TDXDrawLineThickFunc.defaultValue.width,
         lineShape: TDXDrawLineShapeFunc = .defaultValue,
         hasNoDraw: Bool = false) {
        self.id = id
        self.key = key
        self.drawType = drawType
        self.lineColor = lineColor
        self.lineThick = lineThick
        self.lineShape = lineShape
        self.hasNoDraw = hasNoDraw
    }
}


/**
 默认绘制，PRICE位置画线连接
 */
public class TDXDrawDefaultLine: TDXDraw {
    public var price: Double = 0
    ///参数名字
    public var name: String?
}

/**
 在图形上绘制折线段。
 用法：　PLOYLINE(COND，PRICE)，当COND条件满足时，以PRICE位置为顶点画折线连接。
 例如：　PLOYLINE(HIGH>=HHV(HIGH,20),HIGH)表示在创20天新高点之间画折线
 */
@objcMembers
public class TDXDrawPloyline: TDXDraw {
    
    public var price: Double = 0
    ///参数名字
    public var name: String?
}

/**
 在图形上绘制直线段。
 用法：　DRAWLINE(COND1，PRICE1，COND2，PRICE2，EXPAND)
 当COND1条件满足时，在PRICE1位置画直线起点，当COND2条件满足时，在PRICE2位置画直线终点，EXPAND为延长类型。
 例如：　DRAWLINE(HIGH>=HHV(HIGH,20),HIGH,LOW<=LLV(LOW,20),LOW,1)表示在创20天新高与创20天新低之间画直线并且向右延长.
 */
@objcMembers
public class TDXDrawLine: TDXDraw {
    public var price1: Double = 0
    public var price2: Double = 0
}

/**
 用法：　DRAWKLINE(HIGH,OPEN,LOW,CLOSE).　以HIGH为最高价，OPEN为开盘价，LOW为最低，CLOSE收盘画K线。
 */
@objcMembers
public class TDXDrawKine: TDXDraw {
    public var high: Double = 0
    public var open: Double = 0
    public var low: Double = 0
    public var close: Double = 0
}

/**
 在图形上绘制柱线。
 用法：　STICKLINE(COND，PRICE1，PRICE2，WIDTH，EMPTY)，当COND条件满足时，在PRICE1和PRICE2位置之间画柱状线，宽度为WIDTH(10为标准间距)，EMPTH不为0则画空心柱。
 例如：　STICKLINE(CLOSE>OPEN,CLOSE,OPEN,0.8,1)表示画K线中阳线的空心柱体部分.
 */
@objcMembers
public class TDXDrawStickline: TDXDraw {
    public var price1: Double = 0
    public var price2: Double = 0
    public var width: Double = 0
    public var isEmpty: Bool = false
}

/**
 在图形上绘制小图标。
 用法：　DRAWICON(COND，PRICE，TYPE)，当COND条件满足时，在PRICE位置画TYPE号图标。
 例如：　DRAWICON(CLOSE>OPEN,LOW,1)表示当收阳时在最低价位置画1号图标.
 图标一共有九个，图形如附图。序号，最下面的是“1”号，最上面的是“9”号。
 */
@objcMembers
public class TDXDrawIcon: TDXDraw {
    public var price: Double = 0
    public var type: Int = 0
}

/**
 在图形上显示文字。
 用法：　DRAWTEXT(COND，PRICE，TEXT)，当COND条件满足时，在PRICE位置书写文字TEXT。
 例如：　DRAWTEXT(CLOSE/OPEN>1.08,LOW,'大阳线')表示当日实体阳线大于8%时在最低价位置显示'大阳线'字样.
 */
@objcMembers
public class TDXDrawText: TDXDraw {
    public var price: Double = 0
    public var text: String = ""
}

