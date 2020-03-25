//
//  UIImage.swift
//  Flipagram
//
//  Created by 古智鹏 on 2020/1/2.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation

extension UIImage {

    func flipImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        guard let cgImage = self.cgImage else { return self }
        
        context.translateBy(x: self.size.width, y: self.size.height)
        context.scaleBy(x: -self.scale, y: -self.scale)
        context.draw(cgImage, in: CGRect(origin: .zero, size: self.size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    func rotateImage() -> UIImage {
        return self.rotated(by: CGFloat.pi*0.5) ?? self
    }
    
    func resize(size: CGSize) -> UIImage? {
           var width = self.size.width
           var height = self.size.height
           
           UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
           
           let scaleX = width/size.width
           let scaleY = height/size.height
           
           width /= min(scaleX, scaleY)
           height /= min(scaleX, scaleY)
           
           let originX = (size.width - width) / 2.0
           let originY = (size.height - height) / 2.0
           self.draw(in: CGRect(x: originX, y: originY, width: width, height: height))
           
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           
           return newImage
       }
       
       
       func normalized() -> UIImage  {
           if (self.imageOrientation == UIImage.Orientation.up) {
               return self;
           }
           
           UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
           let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
           self.draw(in: rect)
           
           if let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() {
               UIGraphicsEndImageContext()
               return normalizedImage ?? self
           } else {
               return self
           }
       }
       
       func cropped(bounds: CGRect) -> UIImage? {
           guard let cgImage = self.cgImage?.cropping(to: bounds) else { return nil }
           return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
       }
    
       func pixelData() -> [UInt8]? {
           let size = self.size
           let dataSize = size.width * size.height * 4
           var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
           let colorSpace = CGColorSpaceCreateDeviceRGB()
           let context = CGContext(data: &pixelData,
                                   width: Int(size.width),
                                   height: Int(size.height),
                                   bitsPerComponent: 8,
                                   bytesPerRow: 4 * Int(size.width),
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
           guard let cgImage = self.cgImage else { return nil }
           context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
           
           return pixelData
       }
    
}
