//  CLMainViewController.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//
import UIKit

class CLTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
}
extension CLTabBarController {
    
    fileprivate func setUpUI(){
        
        addChildViewController(title: "视频", vc: CLHomeViewController(), imageName: "video")
        
        addChildViewController(title:"我", vc: CLProfileViewController(), imageName: "profile")
      

    }
    
    
    fileprivate func addChildViewController(title:String,vc:UIViewController,imageName:String){
        
        vc.title = title
        //设置默认图片
        vc.tabBarItem.image = UIImage(named:imageName)
        //设置高亮图片
        vc.tabBarItem.selectedImage = UIImage(named: imageName +  "_highlight")?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.cl_colorWithHex(hex: 0x1296db)], for: .selected)
        
        let nav = UINavigationController(rootViewController: vc)
        //添加子控制器
        addChildViewController(nav)
        
    }
    
}

