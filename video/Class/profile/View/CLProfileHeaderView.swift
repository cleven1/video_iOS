//
//  CLProfileHeaderView.swift
//  video
//
//  Created by cleven on 2018/8/22.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CLProfileHeaderView: UIView {
    
    private var userAvatarImage:UIImageView?
    private var nameLabel:UILabel?
    private var userIdLabel:UILabel?
    private var genderImageView:UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        userAvatarImage = UIImageView(imageName: "avatar_empty")
        userAvatarImage?.layer.cornerRadius = 39
        userAvatarImage?.layer.masksToBounds = true
        addSubview(userAvatarImage!)
        userAvatarImage?.snp.makeConstraints({ (make) in
            make.leading.equalTo(self).offset(ScreenInfo.Kmargin_10)
            make.top.equalTo(self).offset(ScreenInfo.Kmargin_10)
            make.width.height.equalTo(78)
        })
        
        nameLabel = UILabel(text: "昵称: " + (CLUserManager.sharedManager.name ?? ""), textColor: UIColor.black, fontSize: 12)
        addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(userAvatarImage!).offset(-ScreenInfo.Kmargin_15)
            make.leading.equalTo(userAvatarImage!.snp.trailing).offset(ScreenInfo.Kmargin_10)
        })
        
        var genderImageName:String = "woman"
        if CLUserManager.sharedManager.gender == 1 {
            genderImageName = "man"
        }
        genderImageView = UIImageView(imageName: genderImageName)
        addSubview(genderImageView!)
        genderImageView?.snp.makeConstraints({ (make) in
            make.leading.equalTo(nameLabel!.snp.trailing).offset(ScreenInfo.Kmargin_15)
            make.centerY.equalTo(nameLabel!)
        })
        
        userIdLabel = UILabel(text: "id: " + (CLUserManager.sharedManager.user_id ?? ""), textColor: UIColor.black, fontSize: 12)
        addSubview(userIdLabel!)
        userIdLabel?.snp.makeConstraints({ (make) in
            make.leading.equalTo(nameLabel!)
            make.centerY.equalTo(userAvatarImage!).offset(ScreenInfo.Kmargin_15)
        })
        
        let marginView = UIView(frame: CGRect(x: 0, y: self.bounds.height - ScreenInfo.Kmargin_15, width: self.bounds.width, height: ScreenInfo.Kmargin_15))
        marginView.backgroundColor = UIColor.cl_RGBColor(r: 243, g: 243, b: 243)
        addSubview(marginView)
    
        
    }
    
    
    
}

