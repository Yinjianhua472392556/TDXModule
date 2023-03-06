//
//  TDXInterpreter+Time.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation
import SwifterSwift

extension TDXInterpreter {
    
    public func handleTime(_ name: String) -> Any {
        
        let f = TDXTimeFunc.type(name)
        guard let p = firstData() else {
            TDXFuncError.getTimeFailed(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch f {
        case .unknown:
            TDXFuncError.unexpectedFunc(name:name).throwError()
            return TDXInvalidReturn
        case .period:
            return period(p)
        case .date:
            return timeDate()
        case .time:
            return timeTime(p)
        case .time2:
            return timeTime2(p)
        case .year:
            return timeYear(p)
        case .month:
            return timeMonth(p)
        case .weekofyear:
            return timeWeekOfYear(p)
        case .weekday:
            return timeWeekDay()
        case .daystotoday:
            return timeDaysToToday()
        case .day:
            return timeDay(p)
        case .hour:
            return timeHour(p)
        case .minute:
            return timeMinute(p)
        case .fromopen:
            return timeFromOpen(p)
        }
    }
        
}


extension TDXInterpreter {
    
    /**
     类型：时间函数
     功能：周期类型
     描述：取得周期类型。
     结果从0到13，依次分别是1/5/15/30/60分钟、日/周/月，多分钟、多日/季/年、5秒线/多秒线、13以上为自定义周期。
                        0 1  2   3   4              5  6  7         8            9  10  11    12       13
     */
    func period(_ param: Any) -> Any {
        
//        typedef GPB_ENUM(PeriodType) {
//          PeriodType_Min1 = 1,
//          PeriodType_Min3 = 2,
//          PeriodType_Min5 = 3,
//          PeriodType_Min15 = 4,
//          PeriodType_Min30 = 5,
//          PeriodType_Min60 = 6,
//          PeriodType_Min120 = 7,
//          PeriodType_Min180 = 8,
//          PeriodType_Min240 = 9,
//          PeriodType_Day = 10,
//          PeriodType_Week = 11,
//          PeriodType_Month = 12,
//          PeriodType_Season = 13,
//          PeriodType_HalfYear = 14,
//          PeriodType_Year = 15,
//        };
        
        guard let periodType = jobData?.periodType else { return  TDXInvalidReturn }
        let dict = [1: 0, 2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 4, 8: 4, 9: 4, 10: 5, 11: 6, 12: 7, 13: 10, 14: 10, 15: 11]
        
        guard let value = dict[periodType] else { return  TDXInvalidReturn }
        return value
    
    }
    
    /**
     描述：该周期从1900以来的年月日。

     用法：DATE;
     返回该周期从1900以来的年月日。
     例如：函数返回1000101，表示2000年1月1日， DATE+19000000后才是真正的日期值。
     */
    func timeDate() -> Any {
//        let index = dataIndex()
//        guard let klines = data as? [DYKLine],
//              let kline = klines[safe: index] else { return TDXInvalidReturn }
//
//        guard let date =  Int64(kline.time).tzyk_timeToDate() else {
//            return TDXInvalidReturn
//        }
//
//        let year  = date.year.string
//        let month = String(format: "%02d", date.month)
//        let day   = String(format: "%02d", date.day)
//        guard var interval = Int(year+month+day) else { return TDXInvalidReturn }
//        interval -= 19000000
//        return interval
        
        return TDXInvalidReturn

    }
    
    /**
     
     类型：时间函数
     功能：时间
     描述：取得该周期的时分，适用于日线以下周期。
     TIME 函数返回有效值范围为 (0000-2359) 。
     */
    func timeTime(_ param: Any) -> Any {
        
//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//        let hour = currentDate.hour
//        let minute = currentDate.minute
//        return Int("\(hour)\(minute)") as Any

        return TDXInvalidReturn

    }
    
    /**
     取得该周期的时分秒,适用于日线以下周期.
     用法:  TIME2 函数返回有效值范围为(000000-235959)
     */
    func timeTime2(_ param: Any) -> Any {
        
//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//        let hour = currentDate.hour
//        let minute = currentDate.minute
//        let second = Date().second
//        return Int("\(hour)\(minute)\(second)") as Any

        
        return TDXInvalidReturn

    }
    
    /**
     类型：时间函数
     功能：年份
     描述：该周期的年份。
     用法：YEAR;
     返回该周期的年份。
     */
    func timeYear(_ param: Any) -> Any {

//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//        let year = currentDate.year
//        return year

        return TDXInvalidReturn
    }
    
    /**
     类型：时间函数
     功能：月份
     描述：该周期的月份。
     用法：MONTH;
     返回该周期的月份，有效值范围为（1 ~ 12）。
     */
    func timeMonth(_ param: Any) -> Any {

//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//        let month = currentDate.month
//        return month
        
        return TDXInvalidReturn


    }
    
    /**
     类型：时间函数
     功能：年内星期
     描述：取得该周是年内第几个周。
     */
    func timeWeekOfYear(_ param: Any) -> Any {
        
//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//        let weekOfYear = currentDate.weekOfYear
//        return weekOfYear
        
        return TDXInvalidReturn
    }
    
    /**
     类型：时间函数
     功能：星期
     描述：该周期的星期数。
     用法：WEEKDAY;
     返回当天是星期几，有效值范围为（1 ~ 7）。
     */
    func timeWeekDay() -> Any {
//        let index = dataIndex()
//        guard let klines = data as? [DYKLine],
//              let kline = klines[safe: index] else { return TDXInvalidReturn }
//
////        let date = Date(timeIntervalSince1970: TimeInterval(kline.time))
//
//        var date : Date?
//        date =  Int64(kline.time).tzyk_timeToDate()
//        guard let date =  date else {
//            return TDXInvalidReturn
//        }
//
//        return date.weekday - 1
        
        return TDXInvalidReturn

    }
    
    /**
     描述：取得周期类型。
     取得该周期的日期离今天的天数.
     */
    
    func timeDaysToToday() -> Any {
        
//        let index = dataIndex()
//        guard let klines = data as? [DYKLine],
//              let kline = klines[safe: index] else { return TDXInvalidReturn }
//
//        var currentDate : Date?
//        currentDate = Int64(kline.time).tzyk_timeToDate()
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//        let today      = Date()
//        let day        = calendar.dateComponents([.day], from: currentDate, to: today).day
//        return day ?? TDXInvalidReturn
        
        return TDXInvalidReturn

    }
    
    /**
     取得该周期的日期.
     用法:  DAY  函数返回有效值范围为(1-31)
     */
    func timeDay(_ param: Any) -> Any {
        
//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//
//
//        let day = currentDate.day
//        return day

        return TDXInvalidReturn

    }
    
    /**
     取得该周期的小时数
     用法: HOUR 函数返回有效值范围为(0-23),对于日线及更长的分析周期值为0
     */
    func timeHour(_ param: Any) -> Any {
        
//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//        let hour = currentDate.hour
//        return hour
        
        return TDXInvalidReturn

    }
    
    /**
     取得该周期的分钟数
     MINUTE　函数返回有效值范围为(0-59)，对于日线及更长的分析周期值为0
     */
    func timeMinute(_ param: Any) -> Any {

//        var currentDate : Date?
//
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//        let minute = currentDate.minute
//        return minute
        
        return TDXInvalidReturn

        
    }
    
    /**
     描述：求当前时刻距开盘有多长时间
     FROMOPEN　返回当前时刻距开盘有多长时间，单位为分钟
     */
    func timeFromOpen(_ param: Any) -> Any {
        
//        let now = Date()
//        var nowString = now.string(withFormat: "yyyy-MM-dd")
//        nowString.append(" 9:30")
//
//        var currentDate : Date?
//        if let k = asKine(param) {
//            currentDate =  Int64(k.time).tzyk_timeToDate()
//        }else if let m = asMin(param) {
//            currentDate =  Int64(m.time).tzyk_timeToDate()
//        }
//        
//        guard let currentDate =  currentDate else {
//            return TDXInvalidReturn
//        }
//
//
//        guard let currentDate = currentDate.string(withFormat: "yyyy-MM-dd HH:mm").date, let openTimeDate = nowString.date(withFormat: "yyyy-MM-dd HH:mm") else {
//            return TDXInvalidReturn
//        }
//
//
//
//        let calendar = Calendar.current
//        let diff = calendar.dateComponents([.year,.month, .day, .minute], from: openTimeDate, to: currentDate)
////        let year = diff.year ?? 0
//        let month = diff.month ?? 0
//        let day = diff.day ?? 0
//        let minute = diff.minute ?? 0
//        let total =  month * 30 * 24 * 60 + day * 24 * 60 + minute
//        return total

        
        return TDXInvalidReturn


    }
    
}
