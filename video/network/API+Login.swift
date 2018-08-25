//
//  API+Login.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation

extension HYBNetworking {
    
    class func postUserLogin(mobile:String,password:String,success:@escaping success,failure:@escaping failure) {
        
        let params = ["mobile":mobile,"pwd":password,"identifier":UIDevice.current.identifierForVendor?.uuidString]
        
        HYBNetworking.post(withUrl: "user/login", refreshCache: false, params: params, success: { (response) in
            guard let response = response as? [String:Any] else {return}
            if (response["error_code"] as! String) != "0" {
                failure("error")
                return
            }
            guard let data = response["data"] as? [String:Any] else {failure("error");return}
            
            CLUserManager.sharedManager.createUserData(userData: data)
            
            success(data)
        }) { (error) in
            failure("error")
        }
    }
    
}
