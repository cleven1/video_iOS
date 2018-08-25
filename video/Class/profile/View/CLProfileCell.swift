//
//  CLProfileCell.swift
//  video
//
//  Created by cleven on 2018/8/22.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SnapKit

class CLProfileCell: UITableViewCell {

    private var iconImage:UIImageView?
    private var titleLabel:UILabel?
    private var arrowImage:UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        iconImage = UIImageView()
        contentView.addSubview(iconImage!)
        iconImage?.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview().offset(ScreenInfo.Kmargin_10)
            make.centerY.equalToSuperview()
        })
        
        titleLabel = UILabel(text: "", textColor: UIColor.cl_RGBColor(r: 62, g: 62, b: 62), fontSize: 10)
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImage!.snp.trailing).offset(ScreenInfo.Kmargin_10)
        })
        
        arrowImage = UIImageView(imageName: "arrow_right")
        contentView.addSubview(arrowImage!)
        arrowImage?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ScreenInfo.Kmargin_10)
        })
        
    }

    public func setProfileData(model:CLProfileModel) {
        iconImage?.image = UIImage(named: model.iconName ?? "")
        titleLabel?.text = model.title
    }
    
}
