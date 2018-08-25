//
//  File.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation

extension HYBNetworking {
    
    typealias success = (Any)->()
    typealias failure = (Any)->()
    
    private static var videoListRetry:Int = 0
    
    class func getVideoData(id:String?,ispullup:Bool,category:Int,success:@escaping success,failure:@escaping failure) {
        
        var params:[String:Any]
        if id != nil {
            params = ["id":id!,
                      "ispullup":ispullup ? 1 : 0,
                      "category":category,
                      "limit_count":20
            ]
        }else{
            params = ["ispullup":ispullup ? 1 : 0,
                      "category":category,
                      "limit_count":20
            ]
        }
        HYBNetworking.getWithUrl("video/info", refreshCache: false, params: params, success:  { (response) in
            guard let response = response as? [String:Any] else {failure("");return}
            guard let dataArray = response["data"] as? [[String:Any]] else {failure("");return}
            
            var tempArray:[CLVideoListModel] = [CLVideoListModel]()
            for data in dataArray {
                
                tempArray.append(CLVideoListModel.deserialize(from: data)!)
            }
            
            videoListRetry = 0
            success(tempArray)
        }) { (error) in
            
            if videoListRetry < 3 {
                self.getVideoData(id: id, ispullup: ispullup, category: category, success: success, failure: failure)
            }else{
                videoListRetry = 0
                failure("error")
            }
            videoListRetry += 1
        }
    }
    
}
