//
//  CGFloat.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/12.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
extension CGFloat {
    
    func _$(_ multiple:CGFloat) -> CGFloat {
        var width = Int(self)
        width -= (width % multiple)
        return CGFloat(width)
    }
    
}
