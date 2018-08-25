//
//  IconButton+Extension.swift
//  Wire-iOS
//
//  Created by cleven on 2018/6/21.
//  Copyright © 2018年 Zeta Project Germany GmbH. All rights reserved.
//

import Foundation

public extension UIButton {
    
    enum ImagePosition {
        case left    //图片在左，文字在右，默认
        case right   //图片在右，文字在左
        case top     //图片在上，文字在下
        case bottom  //图片在下，文字在上
    }
    public func imagePostion(postion:ImagePosition,spacing:CGFloat){
        
        let imageWith = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        let labelSize = titleLabel?.attributedText?.size()
        let imageOffsetX = (imageWith! + (labelSize?.width)!) / 2 - imageWith! / 2
        let imageOffsetY = imageHeight! / 2 + spacing / 2
        let labelOffsetX = (imageWith! + (labelSize?.width)! / 2) - (imageWith! + (labelSize?.width)!) / 2
        let labelOffsetY = (labelSize?.height)! / 2 + spacing / 2
        
        switch postion {
        case .left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2)
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2)
            break
        case .right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (labelSize?.width)! + spacing/2, 0, -((labelSize?.width)! + spacing/2))
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight! + spacing/2), 0, imageHeight! + spacing/2)
            break
        case .top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetY - 5, -labelOffsetY, labelOffsetX)
            break
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX)
            break
            
        }
        
    }
    
    func verticalImageAndTitle(_ spacing: CGFloat) {
        let imageSize: CGSize? = imageView?.frame.size
        var titleSize: CGSize? = titleLabel?.frame.size
        let textSize: CGSize? = titleLabel?.text?.size(withAttributes: [NSAttributedStringKey.font: titleLabel?.font ?? 0])
        let frameSize = CGSize(width: CGFloat(ceilf(Float((textSize?.width)!))), height:CGFloat( ceilf(Float((textSize?.height)!))))
        if (titleSize?.width ?? 0.0) + 0.5 < frameSize.width {
            titleSize?.width = frameSize.width
        }
        let totalHeight: CGFloat = (imageSize?.height ?? 0.0) + (titleSize?.height ?? 0.0) + spacing
        imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - (imageSize?.height ?? 0.0)), 0.0, 0.0, -(titleSize?.width ?? 0.0))
        titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize?.width ?? 0.0), -(totalHeight - (titleSize?.height ?? 0.0)), 0)
    }

}
