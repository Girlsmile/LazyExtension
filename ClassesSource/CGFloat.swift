//
//  CGFloat.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/12.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
public extension CGFloat {
    
   @available(iOS, introduced: 2.0, deprecated: 8.0, message: "use _fill() method or _wipe() method instead")
    // MARK: - 向下去余, 一般用于解决视频黑边问题
    func _$(_ multiple:Int) -> CGFloat {
        var width = Int(self)
        width -= (width % multiple)
        return CGFloat(width)
    }
    
    // MARK: - 向下补余, 一般用于解决视频黑边问题
    func _fill(_ multiple:Int) -> CGFloat {
        var width = Int(self)
        width += (width % multiple)
        return CGFloat(width)
    }
    
    // MARK: - 向上去余, 一般用于解决视频黑边问题
    func _wipe(_ multiple:Int) -> CGFloat {
        var width = Int(self)
        width -= (width % multiple)
        return CGFloat(width)
    }
    
}
