//
//  CLVideoCell.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CLVideoCell: UITableViewCell {
    
    private var titleLabel:UILabel?
    private var videoImage:UIImageView?
    private var playImage:UIImageView?
    private var sizeLabel:UILabel?
    private var durationLabel:UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        titleLabel = UILabel(text: "标题", textColor: UIColor.black, fontSize: 14)
        titleLabel?.numberOfLines = 1
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.leading.equalTo(contentView).offset(ScreenInfo.Kmargin_10)
            make.top.equalTo(contentView).offset(ScreenInfo.Kmargin_10)
            make.trailing.equalTo(contentView).offset(-ScreenInfo.Kmargin_10)
        })
        
        let containView = UIView()
        containView.tag = 100
        containView.layer.masksToBounds = true
        contentView.addSubview(containView)
        containView.snp.makeConstraints({ (make) in
            make.leading.equalTo(titleLabel!)
            make.top.equalTo(contentView).offset(35)
            make.trailing.equalTo(contentView).offset(-ScreenInfo.Kmargin_10)
            make.bottom.equalTo(contentView).offset(-30)
        })
        
        videoImage = UIImageView(image: UIImage(named: "image_placeholder"))
        videoImage?.layer.cornerRadius = 5
        videoImage?.layer.masksToBounds = true
        videoImage?.contentMode = .scaleAspectFill
        containView.addSubview(videoImage!)
        videoImage?.snp.makeConstraints({ (make) in
            make.edges.equalTo(containView)
        })
        
        playImage = UIImageView(imageName: "video_Play")
        containView.addSubview(playImage!)
        playImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(containView)
            make.centerY.equalTo(containView)
        })

        
        durationLabel = UILabel(text: "0 min", textColor: UIColor.darkGray, fontSize: 12)
        contentView.addSubview(durationLabel!)
        durationLabel?.snp.makeConstraints({ (make) in
            make.leading.equalTo(videoImage!)
            make.bottom.equalTo(contentView).offset(-ScreenInfo.Kmargin_5)
        })
        
        sizeLabel = UILabel(text: "0.0M", textColor: UIColor.darkGray, fontSize: 12)
        contentView.addSubview(sizeLabel!)
        sizeLabel?.snp.makeConstraints({ (make) in
            make.trailing.equalTo(contentView).offset(-ScreenInfo.Kmargin_10)
            make.top.equalTo(durationLabel!)
        })
        
        layer.masksToBounds = true
        
    }
    
    public func setVideoListData(model:CLVideoListModel?){
        guard let listModel = model else {
            return
        }
        
        titleLabel?.text = listModel.title
        videoImage?.kf.setImage(with: URL(string: listModel.imageUrl ?? ""), placeholder: UIImage(named: "image_placeholder"), options:[], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            if let image = image {
                model?.imageW = image.size.width
                model?.imageH = image.size.height
            }
        })
        durationLabel?.text = listModel.duration
        sizeLabel?.text = listModel.size
    }

}
