//
//  API+VerifyCode.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation


extension HYBNetworking {
    
    class func getVerifyCode(mobile:String,success:@escaping success,failure:@escaping failure) {
        
        HYBNetworking.post(withUrl: "user/smscode", refreshCache: false, params: ["mobile":mobile], success: { (response) in
            success("ok")
        }) { (error) in
            failure("error")
        }
    }
    
}
