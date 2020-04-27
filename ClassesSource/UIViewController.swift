//
//  ViewController.swift
//  VintageCamera
//
//  Created by 古智鹏 on 2020/4/15.
//  Copyright © 2020 MasterGu. All rights reserved.
//

import Foundation
extension UIViewController {
    
    func presentFully(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}
