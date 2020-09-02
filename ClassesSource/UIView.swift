//
//  UIView.swift
//  Flipagram
//
//  Created by 古智鹏 on 2019/12/25.
//  Copyright © 2019 古智鹏. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public extension UIView {
    
    enum Edges {
        case leftTop, rightTop, leftBottom, rightBottom
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func toImage(scale: CGFloat = UIScreen.main.scale) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            if let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                let image = UIImage(cgImage: cgImage)
                UIGraphicsEndImageContext()
                return image
            }
        }
        
        return UIImage()
    }
    
    func setRoundCorner(corners: UIRectCorner, radii: CGFloat) {
        self.layoutIfNeeded()
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setCornerBorder(corners: UIRectCorner, radii: CGFloat, color: UIColor, lineWidth: CGFloat) {
        setRoundCorner(corners: corners, radii: radii)
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: self.bounds.size), byRoundingCorners: corners, cornerRadii: CGSize.init(width: radii, height: radii))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        layer.addSublayer(shape)
    }
    
    func setCorner(_ size: CGFloat) {
        self.layer.cornerRadius = size
        self.layer.masksToBounds = true
    }
    
    /// 添加圆角和阴影 radius:圆角半径 shadowOpacity: 阴影透明度 (0-1) shadowColor: 阴影颜色
    func addRoundedOrShadow(radius:CGFloat, shadowOpacity:CGFloat, shadowColor:UIColor)  {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        let subLayer = CALayer()
        let fixframe = self.frame
        let newFrame = CGRect(x: fixframe.minX-(375-UIScreen.main.bounds.size.width)/2, y: fixframe.minY, width: fixframe.width, height: fixframe.height) // 修正偏差
        subLayer.frame = newFrame
        subLayer.cornerRadius = radius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = shadowColor.cgColor // 阴影颜色
        subLayer.shadowOffset = CGSize(width: 3, height: 3) // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOpacity = Float(shadowOpacity) //阴影透明度
        subLayer.shadowRadius = 12;//阴影半径，默认3
        self.superview?.layer.insertSublayer(subLayer, below: self.layer)
    }
    
    func asImage(croppingRect: CGRect? = nil) -> UIImage {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if let rect = croppingRect {
            let x: CGFloat = floor(rect.minX * scale)
            let y: CGFloat = floor(rect.minY * scale)
            let w: CGFloat = floor(rect.width * scale)
            let h: CGFloat = floor(rect.height * scale)
            
            if let cgImage = image?.cgImage?.cropping(to: CGRect.init(x: x, y: y, width: w, height: h)) {
                return UIImage(cgImage: cgImage)
            }
        } else if let cgImage = image?.cgImage {
            return UIImage(cgImage: cgImage)
        }
        
        return UIImage()
    }
    
    func dotInsert(color: UIColor = UIColor(hex:0xFF4630), edage: Edges = .rightTop, radius: CGFloat = 5.0, inset: CGFloat = 2.0) {
        
        subviews.forEach({
            if $0.tag == 998 {
                $0.removeFromSuperview()
            }
        })
        
        let view = UIView()
        view.backgroundColor = color
        view.tag = 998
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
        
        self.addSubview(view)
        
        switch  edage {
            case .leftBottom:
                view.snp.remakeConstraints { (make) in
                    make.left.bottom.equalToSuperview().inset(inset)
                    make.size.equalTo(radius*2)
                }
            case .leftTop:
                view.snp.remakeConstraints { (make) in
                    make.left.top.equalToSuperview().inset(inset)
                    make.size.equalTo(radius*2)
                }
            case .rightBottom:
                view.snp.remakeConstraints { (make) in
                    make.right.bottom.equalToSuperview().inset(inset)
                    make.size.equalTo(radius*2)
                }
            case .rightTop:
                view.snp.remakeConstraints { (make) in
                    make.right.top.equalToSuperview().inset(inset)
                    make.size.equalTo(radius*2)
                }
        }
        
        view.isHidden = false
    }
    
    func dotDismiss() {
        subviews.forEach({
            if $0.tag == 998 {
                $0.isHidden = true
                $0.removeFromSuperview()
            }
        })
    }
    
    
}


public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, a: alpha)
    }

}
