//
//  CLUserManager.swift
//  video
//
//  Created by cleven on 2018/8/24.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CLUserManager: NSObject {

    static var sharedManager:CLUserManager = CLUserManager()
    
    var user_id:String?
    var name:String?
    var mobile:String?
    var avatar_url:String?
    var gender:Int = 0 //0:女 1:男
    
    
    public func createUserData(userData:[String:Any]) {
        user_id = userData["user_id"] as? String
        name = userData["name"] as? String
        mobile = userData["mobile"] as? String
        avatar_url = userData["avatar_url"] as? String
        gender = userData["gender"] as! Int
        
        // 保存 登陆数据
        let userD = UserDefaults.standard
        userD.set(userData, forKey: "CLUserProfileData")
        userD.synchronize()
        
    }
    
    // 获取用户数据
    public func getUserData(){
        let userD = UserDefaults.standard
        guard let data = userD.value(forKey: "CLUserProfileData") as? [String:Any] else {return}
        createUserData(userData: data)
    }
    
    // 删除用户数据
    public func deleteUserData(){
        let userD = UserDefaults.standard
        userD.removeObject(forKey: "CLUserProfileData")
        userD.synchronize()
    }

}
