//
//  Range.swift
//  Glitch
//
//  Created by 古智鹏 on 2020/3/3.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
public extension Range where Bound: FixedWidthInteger {
    
    var random: Bound { .random(in: self) }
    
    func random(_ n: Int) -> [Bound] { (0..<n).map { _ in random } }
    
}

public extension ClosedRange where Bound: FixedWidthInteger  {
    
    var random: Bound { .random(in: self) }
    
    func random(_ n: Int) -> [Bound] { (0..<n).map { _ in random }
        
    }
    
}
