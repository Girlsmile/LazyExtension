//
//  BaseNavigateController.swift
//  CertificateCamera
//
//  Created by 古智鹏 on 2020/2/18.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
class BaseNavigateController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }
}