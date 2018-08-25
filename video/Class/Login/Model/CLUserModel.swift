//
//  CLUserModel.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import HandyJSON

struct CLUserModel: HandyJSON {

    var user_id:String?
    var name:String?
    var mobile:String?
    var avatar_url:String?
    var gender:Int = 0 //0:女 1:男
    
}

struct CLUSerRegisterModel:HandyJSON {
    var name:String?
    var pwd:String?
    var mobile:String?
    var avatar_url:String?
    var gender:Int = 0 //0:女 1:男
    var sms_code:String?
    var identifier:String? //手机唯一标示
}
