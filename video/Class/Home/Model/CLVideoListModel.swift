//
//  CLVideoListModel.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import HandyJSON

class CLVideoListModel:HandyJSON {

    var category:Int = 0
    var videoUrl:String?
    var title:String?
    var imageUrl:String?
    var duration:String?
    var id:String?
    var size:String?
    var imageW:CGFloat = 0
    var imageH:CGFloat = 0
    
    required init() { }
    
}
