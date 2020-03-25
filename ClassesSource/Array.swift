//
//  Array.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/2.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
public extension Array {
    
    /// 自定义下标写法
    /// subscript用于更方便的访问集合中的数据
    /// indices.contains用于判断索引值是否在区间类
    /// - Parameter index: 索引值
    public subscript(safe index:Int) -> Element? {
        if(indices.contains(index)){
            return self[index];
        }else{
            return nil;
        }
    }
    
    
    /// 普通写法
    ///
    /// - Parameter index: 索引值
    /// - Returns:
    public func indexSafe(index:Int) -> Element? {
        if(index > 0 && index < count){
            return self[index];
        }
        
        return nil;
    }
    
    
}
