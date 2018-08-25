//
//  API+Register.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation


extension HYBNetworking {
    
    
    class func postRegisterUserData(registerModel:CLUSerRegisterModel,success:@escaping success,failure:@escaping failure) {
        
        HYBNetworking.post(withUrl: "user/register", refreshCache: false, params: registerModel.toJSON(), success:
            { (response) in
            guard let response = response as? [String:Any] else {return}
            if (response["error_code"] as! String) != "0" {
                failure(["error":response["error_msg"] as! String])
                return
            }
            success("ok")
        }) { (error) in
            failure(["error":"注册失败"])
        }
    }
    
}
