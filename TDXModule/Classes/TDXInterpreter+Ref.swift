//
//  TDXInterpreter+Ref.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/5.
//

import Foundation
import SwifterSwift

extension TDXInterpreter {
    
    public func handleRef(_ node: TDXCallNode) -> Any {
        let name = node.name
        guard let type = TDXRefFunc(rawValue: name) else {
            TDXFuncError.unexpectedFunc(name: name).throwError()
            return TDXInvalidReturn
        }
        
        switch type {
            

        case .sumBars:
            guard let x = node.params.first, let a = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return sumBars(x: x, a: a, callNode: node)
            
        case .totalBarsCount:
            return totalBarsCount()
            
        case .currBarsCount:
            
            return currBarsCount()
            
        case .barsCount:
            guard let x = node.params.first else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return barsCount(x: x, callNode:node)
            
            
        case .barsLasts:
            guard let x = node.params.first, let n = node.params[safe: 1]  else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return barsLasts(x: x, n: n, callNode: node)
            
        case .barsLast:
            guard let x = node.params.first else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return barsLast(x: x, callNode: node)
            
        case .barsLastCount:
            return barsLastCount(node)
            
        case .barsSince:
            guard let x = node.params.first else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return barsSince(x: x, callNode: node)
            
        case .const:
            guard let x = node.params.first else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return const(x: x)
            
            
        case .sma:
            guard let x = node.params.first, let n = node.params[safe: 1], let m = node.params[safe: 2] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return sma(x: x, n: n, m: m, callNode : node)
            
        case .mema:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return mema(x: x, n: n, callNode: node)
            
            
            
        case .ema, .expmema:
            ///修改版本
//            return ema(node)
            
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return ema(x: x, n: n, callNode:node)
            
        case .dma:
            
            guard let x = node.params.first, let a = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return dma(x: x, a: a, callNode:node)
            
            
        case .reverse:
            guard let x = node.params.first else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return reverse(x: x)
            
        case .hhv:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return hhv(x: x, n: n, isMax:true, callNode: node)
            
        case  .llv:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return llv(x: x, n: n, callNode:node)
            
            
        case .llvbars:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return llvbars(x: x, n: n, callNode: node)
            
        case .ref:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return ref(x: x, a: n)
            
        case .hhvbars:
            
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            let r =  hhvbars(x: x, n: n, callNode: node, isMax: true)
            return r
            
        case .count:
            ///修改版
            return count(node)
            
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            let ersu = count(x: x, n: n, callNode: node);

            return ersu
            
        case .drawnull:
            return drawnull()
            
        case .ma:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return ma(x: x, n: n, callNode: node)
                        
        case .range:
            guard let a = node.params.first, let b = node.params[safe: 1], let c = node.params[safe: 2] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return range(a: a, b: b, c:c)
            
            
        case .sum:
            guard let a = node.params.first, let b = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return sum(a: a, b: b, callNode: node)
        case .ref:
            guard let x = node.params.first, let a = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return ref(x: x, a: a)
            
        case .refDate:
            guard let x = node.params.first, let n = node.params[safe: 1] else {
                TDXFuncError.getParamFailed(name: name).throwError()
                return TDXInvalidReturn
            }
            return refDate(x: x, n: n, callNode: node)
            
        case .avedev:
            return avedev(node)
        case .unknown:
            break
        }
        
        return TDXInvalidReturn
    }
    
    
    func drawnull() -> Any  {
        return TDXInvalidReturn
    }
    
    /*
     DMA 动态移动平均
     求动态移动平均。
     用法：　DMA(X，A)　求X的动态移动平均。
     算法：　若Y=DMA(X，A)则 Y=A*X+(1-A)*Y'，其中Y'表示上一周期Y值，A必须小于1。
     例如：　DMA(CLOSE,VOL/CAPITAL)表示求以换手率作平滑因子的平均价
    
     **/
    
    func dma(x: TDXNode, a: TDXNode, callNode :TDXCallNode) -> Double  {
        
        var resetAResult = false
        let curIdx = dataIndex()
        
        var lastY : Double = 0
        
        var yResultArr = [Double]()
        
        
        if let cacheResult = jobData?.dmaFuncResult[callNode] {
            yResultArr = cacheResult
        }else{
            for (idx,item) in data.enumerated(){
                saveDataIndex(idx)
                
                if let curXResult = asNumber(genericVisit(x)),let aResult = asNumber(genericVisit(a)){
               
                    if aResult > 1 || aResult < 0{
                        resetAResult = true
                    }
                    
                    if lastY == 0{
                        lastY = curXResult
                    }
                    
                    if resetAResult{
                        lastY = curXResult
                    }else{
                        lastY = (aResult *  curXResult  +  lastY * (1 - aResult))
                    }
                    yResultArr.append(lastY)
                }
            }
            jobData?.dmaFuncResult[callNode] = yResultArr
        }
        
        
        if yResultArr.count > curIdx{
            return yResultArr[safe: curIdx] ?? TDXInvalidReturn
        }else{
            return TDXInvalidReturn
        }

    }
    
    func ema(x: TDXNode, n: TDXNode, callNode :TDXCallNode) -> Double  {
        let curIdx = dataIndex()
        guard  let nResult = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        let period = Int(nResult)
        guard periodIsValid(period) else {
            return TDXInvalidReturn
        }
        
        let r = validIndexCollection(period)
        var lastY : Double = 0 //取X的值作为 第一个Y'
        
        if let cacheResult = jobData?.emaFuncResult[callNode] {
            return cacheResult[curIdx] ?? TDXInvalidReturn
        }
        
        
        var resultDict = [Int : Double]()
        for (idx, item) in data.enumerated(){
            
            saveDataIndex(idx)
            if let curXResult = asNumber(genericVisit(x)) {
                if lastY == 0{
                    lastY = curXResult;
                }
                lastY = (2 *  curXResult  +  lastY * (nResult - 1) ) / ( nResult + 1)
                
                resultDict[idx] = lastY
            }
        }
            
        
        jobData?.emaFuncResult[callNode] = resultDict
        return resultDict[curIdx] ?? TDXInvalidReturn
        
    }
    
    
    
    
    
    /*
     MEMA(X,N):X的N日平滑移动平均,如Y=(X+Y'*(N-1))/N
     MEMA(X,N)相当于SMA(X,N,1)
     **/
    func mema(x: TDXNode, n: TDXNode, callNode :TDXCallNode) -> Double {
        
        guard  let nResult = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }

        let period = Int(nResult)
        guard periodIsValid(period) else {
            return TDXInvalidReturn
        }
        
        let r = validIndexCollection(period)
        var lastY : Double = 0

        let curIdx = dataIndex()

        
        if let cacheResult = jobData?.memaFuncResult[callNode] {
            return cacheResult[curIdx] ?? TDXInvalidReturn
        }
      
        
        var resultDict = [Int : Double]()
        for (idx, item) in data.enumerated(){
            saveDataIndex(idx)
            if let curXResult = asNumber(genericVisit(x)) {
                if lastY == 0{
                    lastY = curXResult;
                }
                lastY = ( curXResult  +  lastY * (nResult - 1) ) / nResult
                resultDict[idx] = lastY
            }
        }
        
        
        jobData?.memaFuncResult[callNode] = resultDict
        return resultDict[curIdx] ?? TDXInvalidReturn

    }
    
    
    
    
    
    
    /*
     SMA 移动平均
     返回移动平均。
     用法：　SMA(X，N，M)　X的N日移动平均，M为权重，如Y=( X*M + Y'* (N-M) ) / N
     **/
    func sma(x: TDXNode, n: TDXNode, m: TDXNode, callNode :TDXCallNode) -> Double {
        
        guard  let nResult = asNumber(genericVisit(n)), let mResult = asNumber(genericVisit(m)) else {
            return TDXInvalidReturn
        }

        let period = Int(nResult)
        guard periodIsValid(period) else {
            return TDXInvalidReturn
        }
        
        let r = validIndexCollection(period)

        var lastY : Double = 0
        let curIdx = dataIndex()


        if let cacheResult = jobData?.smaFuncResult[callNode] {
            return cacheResult[curIdx] ?? TDXInvalidReturn
        }
        
        
        var resultDict = [Int : Double]()
        for (idx, item) in data.enumerated(){
            saveDataIndex(idx)
            if let curXResult = asNumber(genericVisit(x)) {
                if lastY == 0{
                    lastY = curXResult;
                }
                lastY = ( curXResult * mResult +  lastY * (nResult - mResult) ) / nResult
                resultDict[idx] = lastY
            }
        }
        
        
        jobData?.smaFuncResult[callNode] = resultDict
        return resultDict[curIdx] ?? TDXInvalidReturn
    }
    
    
    
    /*
     EXPMEMA 指数平滑移动平均
     返回指数平滑移动平均。
     用法：　EXPMEMA(X，M)　X的M日指数平滑移动平均。
     EXPMEMA同EMA(即EXPMA)的差别在于他的起始值为一平滑值
     
     EXPMEMA 和 EMA相同
     **/
    
//    func expmema(x: TDXNode, n: TDXNode) -> Double  {
//
//        return ema(x: x, n: n)
//
//    }
//
    
    
    func ma(x: TDXNode, n: TDXNode, callNode : TDXCallNode) -> Double {
        
        let curIdx = dataIndex()

        guard let N = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        let period = Int(N)
        
        if let cache = jobData?.maFuncResult[callNode] {
            return cache[curIdx] ?? TDXInvalidReturn
        }
        
        
        var itemDict = [Int : Double]()
        var resultDict = [Int : Double]()
        var caculateCount : Double = 0
        
        for (idx, item) in data.enumerated(){
            saveDataIndex(idx)

            if let xResult = asNumber(genericVisit(x)) {
                itemDict[idx] = xResult
                caculateCount += xResult
            }
            
            if idx >= period - 1{
                if idx > period - 1{
                    if let item = itemDict[idx - period], item != TDXInvalidReturn{
                        caculateCount -= item
                    }
                }
                resultDict[idx] = caculateCount / Double(period)
            }else{
                resultDict[idx] = TDXInvalidReturn
            }
        }
                
        jobData?.maFuncResult[callNode] = resultDict
        return resultDict[curIdx] ?? TDXInvalidReturn
    }
    
    
    
    
    
    
    
    
    
    /*
     SUMBARS 累加到指定值的周期数
     向前累加到指定值到现在的周期数。
     用法：　SUMBARS(X，A)　将X向前累加直到大于等于A，返回这个区间的周期数。
     例如：　SUMBARS(VOL,CAPITAL)求完全换手到现在的周期数
     **/
    func sumBars(x: TDXNode, a: TDXNode, callNode: TDXCallNode) -> Double {
        
        guard let max = asNumber(genericVisit(a)) else {
            return TDXInvalidReturn
        }
        
        let curIdx = dataIndex()
        
        var caculateResult : Double = 0
        var fitIndex = 0

        for idx in (0...curIdx).reversed(){
            saveDataIndex(idx)
            if let result = asNumber(genericVisit(x)) {
                caculateResult += result
                if caculateResult >= max{
                    fitIndex = idx
                    break
                }
            }
        }
                
        return  Double(curIdx - fitIndex) + 1
    }
    
    
    
    
    
    
    
    
    
    
    
    /*
     FILTER(CLOSE>OPEN,5),表示如果今天收阳线，那么随后的5天，不管收阳与否都返回 FALSE。
     **/
    func filter()  {
        
        
    }
    
    
    
    func totalBarsCount() -> Double {
        return Double(data.count)
    }
    
    func currBarsCount() -> Double {
        
        let curIdx = dataIndex()
        let count = data.count
        
        return Double(count - curIdx - 1)
    }
    
    /*
     求总的周期数。
     用法：　BARSCOUNT(X)　第一个有效数据到当前的天数。
     例如:BARSCOUNT(CLOSE)对于日线数据取得上市以来总交易日数
     **/
    
    func barsCount(x: TDXNode, callNode : TDXCallNode) -> Double {
        let curIdx = dataIndex()
                    
        if let validIdx = jobData?.barsCountFuncResult[callNode],  validIdx != -1{
            return Double(curIdx) - validIdx
        }
        
        var validIndex = -1;
        
        for (idx, _) in data.enumerated(){

            saveDataIndex(idx)
            let result = genericVisit(x)
                        
            if let _ = asNumber(result) {
                validIndex = idx
                break
            }
        }
        
        jobData?.barsCountFuncResult[callNode] = Double(validIndex)
                
        
        return Double(curIdx - validIndex)
    }
    
    
    /**
         BARSLASTS(X, N)
          X倒数第N满足 到现在的周期数
     */
    
    func barsLasts(x: TDXNode,n : TDXNode, callNode : TDXCallNode) -> Double{
        
        guard let N = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        
        var NPeriod =  Int(N)
                
        let curIdx = dataIndex()
        
        if let cache = jobData?.barsLastsFuncResult[callNode]{
            return cache[curIdx] ?? TDXInvalidReturn
        }
        
        
        var lastFitIndex = 0
        var resultDict = [Int : Double]()
        
//        var fitCount = 0
        
        var fitIndexArr = [Int]()
        
        for (idx, item) in data.enumerated(){
            
            if idx == 399{
                
            }
            
            saveDataIndex(idx)
            if asCondition(genericVisit(x)){
                fitIndexArr.append(idx)
                if fitIndexArr.count > NPeriod{
                    fitIndexArr.removeFirst()
                }
            }
            
            if let  lastFitIndex = fitIndexArr.first {
                resultDict[idx] = Double(idx - lastFitIndex)
            }
        }
        
        jobData?.barsLastsFuncResult[callNode] = resultDict
        
        return resultDict[curIdx] ?? TDXInvalidReturn
        
    }
    
    
    /*
     上一次条件成立到当前的周期数。
     用法：　BARSLAST(X)　上一次X不为0到现在的天数。
     例如：　BARSLAST(CLOSE/REF(CLOSE,1)>=1.1)表示上一个涨停板到当前的周期数
     **/
    func barsLast(x: TDXNode, callNode : TDXCallNode) -> Double {
        let curIdx = dataIndex()
        
        if let cache = jobData?.barsLastFuncResult[callNode]{
            return cache[curIdx] ?? TDXInvalidReturn
        }
        
        
        var lastFitIndex = 0
        var resultDict = [Int : Double]()
        for (idx, item) in data.enumerated(){
            
            saveDataIndex(idx)
            if asCondition(genericVisit(x)){
                lastFitIndex = idx
            }
            resultDict[idx] = Double(idx - lastFitIndex)
            
        }
        
        jobData?.barsLastFuncResult[callNode] = resultDict
        
        return resultDict[curIdx] ?? TDXInvalidReturn
    }
    
    
    
    func barsLastCount(_ node: TDXCallNode) -> Double {
        guard let first = node.params.first else {
            return TDXInvalidReturn
        }
        let curIdx = dataIndex()
        let key = node.key
        ///如果缓存中有该数据，则直接取该数据
        if let blcData = jobData?.barsLastCountData,
           blcData.has(key: key) == true,
           let bData = blcData[key],
           !bData.isEmpty,
           curIdx >= 0,
           curIdx < bData.count {
            return bData[curIdx]
        }
        var outputs = [Double]()
        var count = 0.0
        for i in 0..<data.count {
            saveDataIndex(i)
            if asCondition(genericVisit(first)) {
                count += 1
            }else {
                count = 0
            }
            outputs.append(count)
        }
        jobData?.barsLastCountData[key] = outputs
        return outputs[safe: curIdx] ?? TDXInvalidReturn
    }
    
    /*
     BARSSINCE 第一个条件成立位置
     第一个条件成立到当前的周期数。
     用法：　BARSSINCE(X)　第一次X不为0到现在的天数。
     例如：　BARSSINCE(HIGH>10)表示股价超过10元时到当前的周期数
     **/
    func barsSince(x: TDXNode, callNode : TDXCallNode) -> Double {

        
        let curIdx = dataIndex()

        if let cache = jobData?.barsSinceFuncResult[callNode]{
            return cache == -1 ? TDXInvalidReturn : Double(curIdx - cache)
        }
        
        var lastFitIndex = 0
        var result : Int = -1
        for (idx, item) in data.enumerated(){
            saveDataIndex(idx)
            if asCondition(genericVisit(x)){
                result = idx
                break
            }
        }
        
        jobData?.barsSinceFuncResult[callNode] = result
        
        return result == -1 ? TDXInvalidReturn : Double(curIdx - result)
        
    }
    
    
    
    /*
     用法: 　CONST(A)　取A最后的值为常量.
     例如：　CONST(INDEXC)表示取指数现价
     **/
    func const(x: TDXNode) -> Double {
        
        //取最后一个有效数据
        let maxIdx = data.count - 1
        saveDataIndex(maxIdx)

        guard let result = asNumber(genericVisit(x)) else {
            return TDXInvalidReturn
        }
        return result
    }
    
    
    
    /*
     用法：　RANGE(A,B,C)　A在B和C。
     例如：　RANGE(A,B,C)表示A大于B同时小于C时返回1,否则返回0
     **/
    
    func range (a: TDXNode, b: TDXNode, c: TDXNode) -> Double {
        
        guard let a = asNumber(genericVisit(a)), let b = asNumber(genericVisit(b)), let c = asNumber(genericVisit(c)) else {
            return 0
        }
        if a > b, a < c{
            return 1
        }
        return 0
    }
    
    
    
    /*
     用法：　REFDATE(X，A)　引以来  用1900年yA日期的X值。
     例如：　REFDATE(CLOSE,1011208)表示2001年12月08日的收盘价
     REFDATE(CLOSE,1121208)
     101 = 1900 + 101 = 2001
     **/
    func refDate(x: TDXNode, n: TDXNode, callNode : TDXCallNode) -> Double {

        
        
        guard let dateDouble = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        
        
        
        if let cache =  jobData?.refDateFuncResult[callNode]{
            return cache
        }
        
        
        
        let dateNum = Int(dateDouble)
        let paraStr = String(dateNum)
        
        let monthDayCount : Int = 4
        
        //获取和 1900的差值
        let monthDayStr = paraStr.suffix(monthDayCount)
        let yearCount = paraStr.count - monthDayCount
        let yearCountStr = paraStr.prefix(yearCount)
        
        let year = (Int(yearCountStr) ?? 0) + 1900
        let dateStr = "\(year)" + monthDayStr
        
//        let format = DateFormatter.init()
//        format.dateFormat = "yyyyMMdd"
//        let timeStamp = format.date(from: dateStr)?.timeIntervalSince1970 ?? -1

//        if let klines = data as? [DYKLine]{
//
//            for (idx,item) in klines.enumerated(){
//
//                //kline time 为yyyyMMDD
//                let yyyyMMDDStr = String(item.time)
//
//                if yyyyMMDDStr == dateStr{
//                    saveDataIndex(idx)
//                    if let result = asNumber(genericVisit(x)) {
//                        jobData?.refDateFuncResult[callNode] = result
//                        return result
//                    }
//                    return TDXInvalidReturn
//                }
//
////                    if item.time == Int64(timeStamp){
////
////                    saveDataIndex(idx)
////                    if let result = asNumber(genericVisit(x)) {
////                        jobData?.refDateFuncResult[callNode] = result
////                        return result
////                    }
////                    return TDXInvalidReturn
////                }
//            }
//        }
       
        
        return TDXInvalidReturn
    }
    
    
    
    /*
     REVERSE 求相反数
     求相反数。
     用法：　REVERSE(X)　返回-X。
     例如：　REVERSE(CLOSE)返回-CLOSE
     **/
    func reverse(x: TDXNode) -> Double {
        
        guard let r = asNumber(genericVisit(x)) else {
            return TDXInvalidReturn
        }
        let result = -r
        return result
    }
    
    

    
    /*
     ///求最高值。
     ///用法：　HHV(X，N)　求N周期内X最高值，N=0则从第一个有效值开始。
     ///例如：　HHV(HIGH,30)表示求30日最高价
     **/
    func hhv(x: TDXNode, n: TDXNode, isMax: Bool, callNode : TDXCallNode) -> Double {
        
        
        guard let N = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        
        let period = Int(N)
        let curIdx = dataIndex()
        
        guard periodIsValid(period) else {
            return TDXInvalidReturn
        }
                
        if let cacheResult = jobData?.hhvFuncResult[callNode]{
            return cacheResult[curIdx] ?? TDXInvalidReturn
        }
        
        //记录N周期内的价格
        var periodArr = [Double]()
        
        var isAll : Bool = period == 0
        
        var resultDict = [Int : Double]() //[index : (idex对应的极值)]
        
        for (idx,item) in data.enumerated(){
            saveDataIndex(idx)
            
            var r : Double = 0
            if let xResult = asNumber(genericVisit(x)) {
                r = xResult
            }
            periodArr.append(r)

            if isAll{ //代表从第一个有效周期开始
                
                if isMax{
                    resultDict[idx] = periodArr.max()
                }else{
                    resultDict[idx] = periodArr.min()
                }
            }else{
                if periodArr.count >= period{
                    
                    if isMax{
                        resultDict[idx] = periodArr.max()
                    }else{
                        resultDict[idx] = periodArr.min()
                    }
                    periodArr.removeFirst()
                }
            }
        }
        
        jobData?.hhvFuncResult[callNode] = resultDict
                
        let result = resultDict[curIdx]
        
//        print("HHV 计算结果 = \(resultDict), max/min = \(result)")
        
        return result ?? TDXInvalidReturn
    }
    
    
    
    
    
    /*
     用法：　LLV(X，N)　求N周期内X最低值，N=0则从第一个有效值开始。
     例如：　LLV(LOW,0)表示求历史最低价
     **/
    func llv(x: TDXNode, n: TDXNode, callNode : TDXCallNode) -> Double {
        return hhv(x: x, n: n, isMax: false, callNode:callNode)
    }
    
    
    
    
    
    /*
     统计满足条件的周期数。
     用法：　COUNT(X，N)　统计N周期中满足X条件的周期数，若N=0则从第一个有效值开始。
     例如：　COUNT(CLOSE>OPEN,20)表示统计20周期内收阳的周期数
     */
    func count(_ node: TDXCallNode) -> Double {
        let curIdx = dataIndex()
        let key = node.key
        ///如果缓存中有该数据，则直接取该数据
        if let data = jobData?.countData,
           let d = data[key],
           !d.isEmpty,
           curIdx >= 0,
           curIdx < d.count {
            return d[curIdx]
        }
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let p1 = asNumber(genericVisit(pr1)) else {
            return TDXInvalidReturn
        }
        var countData = [Double]()
        var temp = [Double]()
        var count = 0
        let dataCount = data.count
        for i in 0..<dataCount {
            saveDataIndex(i)
            if asCondition(genericVisit(pr0)) {
                count += 1
            }
            let countValue = Double(count)
            
            if let pr1 = params[safe: 1], let p1 = asNumber(genericVisit(pr1)) {
                let param = Int(p1)
                if param == 0 {
                    countData.append(countValue)
                }else {
                    temp.append(countValue)
                    let tIdx = i - param
                    if tIdx >= 0, tIdx < temp.count, let tv = temp[safe: tIdx] {
                        countData.append(countValue - tv)
                    }else {
                        countData.append(countValue)
                    }
                }
            }else {
                temp.append(countValue)
                countData.append(countValue)
            }

        }
        jobData?.countData[key] = countData
        return countData[safe: curIdx] ?? TDXInvalidReturn
    }
    
    func count(x: TDXNode, n: TDXNode, callNode : TDXCallNode) -> Double {
        
        
        guard let N = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }
        
        let period = Int(N)

        guard periodIsValid(period) else {
            return TDXInvalidReturn
        }
        
        let curIdx = dataIndex()
  
        if(period == 0){ //计算data里的所有
            var count : Double = 0
            
            if let cacheResult = jobData?.countFuncResult[callNode] {

                count = cacheResult
                
                if asCondition(genericVisit(x)) {
                    count += 1
                }
                jobData?.countFuncResult[callNode] = count
                return count
            }else{
                
                //没有cache, 且idx为最大 说明是最后一根k线订阅后需要刷新重新计算
                if data.count == curIdx + 1{
                    for (idx,item) in data.enumerated() {
                        saveDataIndex(idx)
                        if asCondition(genericVisit(x)) {
                            count += 1
                        }
                    }
                    return count
                }
            }
            
            if asCondition(genericVisit(x)) {
                count += 1
            }
  
            jobData?.countFuncResult[callNode] = count
            return count
        }
        
        
        
        
        let r = validIndexCollection(period)
        
        var count = 0

        for idx in r {
            saveDataIndex(idx)
            if asCondition(genericVisit(x)) {
                count += 1
            }
        }

        return Double(count)
    }
    
      
    
    
    ///求上一高点到当前的周期数。
    ///用法：　HHVBARS(X，N)　求N周期内X最高值到当前周期数，N=0表示从第一个有效值开始统计。
    ///例如：　HHVBARS(HIGH,0)求得历史新高到到当前的周期数
    
    func hhvbars(x: TDXNode, n: TDXNode, callNode:TDXCallNode, isMax: Bool) -> Double {

        //HHVBARS(close, 5) 求5天内收盘价的最高值, 到当前的天数是多少
        guard let N = asNumber(genericVisit(n)) else {
            return TDXInvalidReturn
        }


        let period = Int(N)
        let curIdx = dataIndex()


        if let cacheResult = jobData?.hhvBarsFuncResult[callNode]{
            return cacheResult[curIdx] ?? TDXInvalidReturn
        }


        let lastMax : Double = 0

        //记录N周期内的价格
        var periodArr = [Double]()

        var lastMaxReuslt : Double = 0
        var maxIndex = 0

        var isAll : Bool = period == 0

        var resultDict = [Int : Double]() //[index : (极值所在的index)]


        for (idx,item) in data.enumerated(){

            saveDataIndex(idx)

            var r : Double = 0
            if let xResult = asNumber(genericVisit(x)) {
                r = xResult
            }
            periodArr.append(r)

            if isAll{
                
                var maxOrMin : Double?
                if isMax{
                    maxOrMin = periodArr.max()
                }else{
                    maxOrMin = periodArr.min()
                }
                
                if  let maxOrMinResult = maxOrMin, let maxOrMinIdx = periodArr.lastIndex(of: maxOrMinResult){
                    let result =  idx - maxOrMinIdx
                    resultDict[idx] = Double(result)
                }
                
            }else{
                
                if idx >= (period - 1){
                    
                    var maxOrMin : Double?
                    if isMax{
                        maxOrMin = periodArr.max()
                    }else{
                        maxOrMin = periodArr.min()
                    }
                    
                    if let maxOrMinResult = maxOrMin,  let maxOrMinIdx = periodArr.lastIndex(of: maxOrMinResult){
                        let result =   period - maxOrMinIdx - 1
                        resultDict[idx] = Double(result)
                    }
                    
                    periodArr.removeFirst()

                }
            }
        }

        jobData?.hhvBarsFuncResult[callNode] = resultDict

        let result = resultDict[curIdx]

        print("HHVBARS 计算结果 = \(resultDict), max/min到 curidx的距离 = \(result)")

        return result ?? TDXInvalidReturn

    }
    
    
    
    
    
    /*
     LLVBARS 上一低点位置
     求上一低点到当前的周期数。
     用法：　LLVBARS(X，N)　求N周期内X最低值到当前周期数，N=0表示从第一个有效值开始统计。
     例如：　LLVBARS(HIGH,20)求得20日最低点到当前的周期数
     **/
    
    func llvbars(x: TDXNode, n: TDXNode, callNode : TDXCallNode) -> Double {
        
        return hhvbars(x: x, n: n, callNode: callNode,isMax: false)
    }
    
    
    
    

    
    
    
    /*
     用法：　SUM(X，N)　统计N周期中X的总和，N=0则从第一个有效值开始。
     例如：　SUM(VOL,0)表示统计从上市第一天以来的成交量总和
     **/
    
    func sum(a: TDXNode, b: TDXNode, callNode : TDXCallNode) -> Double {
        guard  let N = asNumber(genericVisit(b)) else {
            return TDXInvalidReturn
        }
        
        
        let period = Int(N)
        let curIdx = dataIndex()
        
        if let cache = jobData?.sumFuncResult[callNode]{
            return cache[curIdx] ?? TDXInvalidReturn
        }
        
        
        var caculateCount : Double = 0

        var count = 0;
        
        var itemDict = [Int : Double]()
        var resultDict = [Int : Double]()
        
        
        if period == 0{
            for (idx,item) in data.enumerated(){
                
                saveDataIndex(idx)
                if let xResult = asNumber(genericVisit(a)) {
                    caculateCount += xResult
                }
                resultDict[idx] = caculateCount
            }
            
            
        }else{
            
            for (idx,item) in data.enumerated(){

                saveDataIndex(idx)
                if let xResult = asNumber(genericVisit(a)) {
                    itemDict[idx] = xResult
                    caculateCount += xResult
                }else{
                    itemDict[idx] = TDXInvalidReturn
                }
                
                
                if idx >= period - 1{
                    if idx > period - 1{
                        if let item = itemDict[idx - period], item != TDXInvalidReturn{
                            caculateCount -= item
                        }
                    }
                    resultDict[idx] = caculateCount
                }else{
                    resultDict[idx] = caculateCount
                }
                
            }
        }
    

      
        
        
        jobData?.sumFuncResult[callNode] = resultDict
        
        
        if let result = resultDict[curIdx], result != TDXInvalidReturn {
            
            return result
        }
        
        return TDXInvalidReturn
        
        
        
        
//
//        if(period == 0){ //计算data里的所有aResutl的和
//            var result : Double = 0
//
//            for (idx,item) in data.enumerated(){
//                saveDataIndex(idx)
//                if let xResult = genericVisit(a) as? Double  {
//                    result += xResult
//                }
//            }
//            return result / 100
//        }
////
//
//        let indexRange = validIndexCollection(period)
//
//        var r : Double = 0
//
//        for idx in indexRange {
//
//            saveDataIndex(idx)
//            if let xResult = genericVisit(a) as? Double  {
//                r += xResult
//            }
//        }
//
//        return r / 100
    }
    
    /**
     REF 向前引用
     引用若干周期前的数据。
     用法：　REF(X，A)　引用A周期前的X值
     */
    func ref(x: TDXNode, a: TDXNode) -> Double {
        
        guard let pA = asNumber(genericVisit(a)) else {
            return TDXInvalidReturn
        }
        ///向前引用的偏移量
        let offset = Int(pA)
        ///当前作用域下的下标
        let idx = dataIndex()
     
        ///目标下标
        let targetIdx = idx - offset
        
        guard  targetIdx >= 0  else {
            return TDXInvalidReturn
        }
        ///更新当前有效下标到最近的作用域
        saveDataIndex(targetIdx)
        
        guard let pX = asNumber(genericVisit(x)) else {
            return TDXInvalidReturn
        }
        
        return pX
    }
    
    
    
    
    
    
    // MARK: - 周期类 的index
    
    func periodIsValid(_ period : Int)  -> Bool   {
        
        let idx = dataIndex()
        //一般都是从当前idx 往前数多少根, 所以要保证idx之前的data数量 符合period要求
        guard period <= (idx + 1) else{
            return false
        }
        return true
    }
    
    func validIndexCollection(_ period : Int) -> ClosedRange<Int> {
        
        
        let idx = dataIndex()

        
        let leftIndex = (idx + 1) - period
        
        let rightIndex =  leftIndex +  (period - 1)
        
        
        guard leftIndex <= rightIndex else {
            return (0...0)
        }
        
        let ragnge = (leftIndex...rightIndex)
        
        return ragnge

    }
    
    
    func avedev(_ node: TDXCallNode) -> Double {
        let params = node.params
        guard let pr0 = params.first,
              let pr1 = params[safe: 1],
              let p1 = asNumber(genericVisit(pr1)) else {
            return TDXInvalidReturn
        }
        let param = Int(p1)
        guard param > 1 else {
            return TDXInvalidReturn
        }
        let end = dataIndex()
        let start = end - param + 1
        guard start >= 0, end >= start else {
            return TDXInvalidReturn
        }
        var tData = [Double]()
        ///获取所有的值
        for i in start...end {
            saveDataIndex(i)
            if let v = asNumber(genericVisit(pr0)) {
                tData.append(v)
            }
        }
        let ma = tData.sum() / p1
        let s = tData.map({ abs($0 - ma) }).sum() / p1
        return s
    }
        
}
