//
//  TDXStack.swift
//  TDXModule
//
//  Created by 尹建华 on 2023/3/6.
//

import Foundation

public class TDXActivationRecord {
    
    let name: String
    let level: Int
    ///变量存储
    var members = [String: Any]()

    init(name: String, level: Int, members: [String : Any] = [String: Any]()) {
        self.name = name
        self.level = level
        self.members = members
    }
    
    func setMember(_ node: Any, with key: String) {
        members[key] = node
    }
    
    func member(with key: String) -> Any? {
        return members[key]
    }
}


public class TDXCallStack {
    
    var records = [TDXActivationRecord]()
    
    func push(_ ar: TDXActivationRecord) {
        records.append(ar)
    }
    
    func pop() -> TDXActivationRecord? {
        guard records.count > 1 else {
            return nil
        }
        return records.removeLast()
    }
    
    func peek() -> TDXActivationRecord? {
        return records.last
    }
}
