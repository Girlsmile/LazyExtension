//
//  UIImage.swift
//  Flipagram
//
//  Created by 古智鹏 on 2020/1/2.
//  Copyright © 2020 古智鹏. All rights reserved.
//

import Foundation

extension UIImage {


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
