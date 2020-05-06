//
//  BaseNavigateController.swift
//  CertificateCamera
//
//  Created by 古智鹏 on 2020/2/18.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation
public class BaseNavigateController: UINavigationController {
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }
}


public protocol VCWithBackButtonHandler {
    func shouldPopOnBackButton() -> Bool
}

extension UINavigationController: UINavigationBarDelegate  {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        if viewControllers.count < (navigationBar.items?.count) ?? 0 {
            return true
        }
        
        var shouldPop = true
        let vc = self.topViewController
        
        if let vc = vc as? VCWithBackButtonHandler {
            shouldPop = vc.shouldPopOnBackButton()
        }
        
        if shouldPop {
            DispatchQueue.main.async {[weak self] in
                _ = self?.popViewController(animated: true)
            }
        } else {
            for subView in navigationBar.subviews {
                if(0 < subView.alpha && subView.alpha < 1) {
                    UIView.animate(withDuration: 0.25, animations: {
                        subView.alpha = 1
                    })
                }
            }
        }
        
        return false
    }
}

