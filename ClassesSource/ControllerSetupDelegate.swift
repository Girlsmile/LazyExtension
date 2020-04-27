//
//  ControllerHelperDelegate.swift
//  VoiceReverse
//
//  Created by 古智鹏 on 2019/12/3.
//  Copyright © 2019 古智鹏. All rights reserved.
//

import Foundation
@objc public protocol ControllerSetupDelegate: class {
    
    func setupUI()
    
    func setupConstrains()
    
    func setupNavigateBar()
    
    func setupNotification()
    
    @objc optional func setupBanner()

}
