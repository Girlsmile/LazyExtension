//
//  CGFloat.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/12.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
extension CGFloat {
    
    func _$4() -> CGFloat {
        var width = Int(self)
        width -= (width % 4)
        return CGFloat(width)
    }
    
}
