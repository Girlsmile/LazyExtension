//
//  CGFloat.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/12.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
public extension CGFloat {
    
    // MARK: - 向下去余, 一般用于解决视频黑边问题
    func _$(_ multiple:Int) -> CGFloat {
        var width = Int(self)
        width -= (width % multiple)
        return CGFloat(width)
    }
    
}
