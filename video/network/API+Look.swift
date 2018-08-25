//
//  API+Look.swift
//  video
//
//  Created by cleven on 2018/8/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation


extension HYBNetworking {
    
    // 添加我看过的
    class func addLookVideo(videoId:String,success:@escaping success,failure:@escaping failure) {
        
        let params = ["video_id":videoId]
        
        HYBNetworking.post(withUrl: "video/addLook", refreshCache: false, params: params, success: { (response) in
            guard let response = response as? [String:Any] else {return}
            if (response["error_code"] as! String) != "0" {
                failure(["error":response["error_msg"] as! String])
                return
            }
            success("ok")
        }) { (error) in
            failure(["error":"添加失败"])
        }
    }

    // 获取我看过的数据
    class func getLookVideos(videoId:String?,ispullup:Bool,success:@escaping success,failure:@escaping failure) {
        
        var params:[String:Any]
        if videoId != nil {
            params = ["id":videoId!,
                      "ispullup":ispullup ? 1 : 0,
                      "limit_count":20
            ]
        }else{
            params = ["ispullup":ispullup ? 1 : 0,
                      "limit_count":20
            ]
        }
        
        HYBNetworking.getWithUrl("video/look", refreshCache: false, params: params, success: { (response) in
            guard let response = response as? [String:Any] else {return}
            if (response["error_code"] as! String) != "0" {
                failure(["error":response["error_msg"] as! String])
                return
            }
            guard let dataArray = response["data"] as? [[String:Any]] else {failure(["error":"获取数据失败"]);return}
            
            var tempArray:[CLVideoListModel] = [CLVideoListModel]()
            for data in dataArray {
                
                tempArray.append(CLVideoListModel.deserialize(from: data)!)
            }
            success(tempArray)
        }) { (error) in
            failure(["error":"获取失败"])
        }
        
    }

    
}
