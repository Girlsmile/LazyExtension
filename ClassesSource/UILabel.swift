//
//  UILabel.swift
//  FakeText
//
//  Created by 古智鹏 on 2019/6/27.
//  Copyright © 2019 古智鹏. All rights reserved.
//

import Foundation

public extension UILabel {
    
    @available(iOS 8.2, *)
    func setFont(_ size: CGFloat, weight: UIFont.Weight, color: UIColor = UIColor.black) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
    }
    
}
