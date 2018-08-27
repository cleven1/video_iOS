//
//  WiriImageUtil.swift
//  Wire-iOS
//
//  Created by cleven on 2018/6/25.
//  Copyright © 2018年 Zeta Project Germany GmbH. All rights reserved.
//

import UIKit

class CLImageUtil: NSObject {

    ///图片压缩方法
    class func resetImgSize(sourceImage : UIImage,maxImageLenght : CGFloat = 1024.0,maxSizeKB : CGFloat = 1024.0) -> Data {
        
        var maxSize = maxSizeKB
        
        var maxImageSize = maxImageLenght
        
        if (maxSize <= 0.0) {
            
            maxSize = 1024.0;
            
        }
        if (maxImageSize <= 0.0)  {
            
            maxImageSize = 1024.0;
        }
        
        //先调整分辨率
        var newSize = CGSize.init(width: sourceImage.size.width, height: sourceImage.size.height)
        
        let tempHeight = newSize.height / maxImageSize;
        
        let tempWidth = newSize.width / maxImageSize;
        
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            
            newSize = CGSize.init(width: sourceImage.size.width / tempWidth, height: sourceImage.size.height / tempWidth)
            
        }
            
        else if (tempHeight > 1.0 && tempWidth < tempHeight){
            
            newSize = CGSize.init(width: sourceImage.size.width / tempHeight, height: sourceImage.size.height / tempHeight)
            
        }
        
        UIGraphicsBeginImageContext(newSize)
        
        sourceImage.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        var imageData = UIImageJPEGRepresentation(newImage!, 1.0)
        
        var sizeOriginKB : CGFloat = CGFloat((imageData?.count)!) / 1024.0;
        
        //调整大小
        var resizeRate = 0.9;
        
        while (sizeOriginKB > maxSize && resizeRate > 0.1) {
            
            imageData = UIImageJPEGRepresentation(newImage!,CGFloat(resizeRate));
            
            sizeOriginKB = CGFloat((imageData?.count)!) / 1024.0;
            
            resizeRate -= 0.1;
            
        }
        
        return imageData!
        
    }
    
}

extension UIImage {
    
    //ImageIO
    func resizeIO(size:CGSize) -> UIImage? {
        
        guard let data = UIImagePNGRepresentation(self) else { return nil }
        
        let maxPixelSize = max(size.width, size.height)
        
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        //kCGImageSourceThumbnailMaxPixelSize为生成缩略图的大小。当设置为800，如果图片本身大于800*600，则生成后图片大小为800*600，如果源图片为700*500，则生成图片为800*500
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        
        let resizedImage = CGImageSourceCreateImageAtIndex(imageSource, 0, options as CFDictionary).flatMap{
            UIImage(cgImage: $0)
        }
        return resizedImage
    }
}
