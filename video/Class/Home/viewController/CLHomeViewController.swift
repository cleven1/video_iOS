//
//  ViewController.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

enum videoCategoryType:Int {
    case all = 0
    case uniform = 1
    case long_hose
    case student
    case lolita
    case miniskirt
    case double_ponytail
    case young_girl_lolita
    case china_lolita
    case china
    case japan
    case korea
    case Europe_and_America
}


class CLHomeViewController: CLRootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        
    }
    
    
    private func setupUI(){
        
        let titleAarry = ["全部","制服","长筒袜","学生","萝莉","超短裙","双马尾","幼女萝莉","中国幼女","中国","日本","韩国","欧美"]
        
        var viewControllerArray:[CLVideoViewController] = [CLVideoViewController]()
        
        for i in 0..<titleAarry.count {
            let vc = CLVideoViewController(categoryType: videoCategoryType(rawValue: i)!)
            viewControllerArray.append(vc)
        }
        

        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScrollEnable = true
        style.titleColor = UIColor.black
        style.titleSelectedColor = UIColor.red
        style.isTitleScrollEnable = true
        style.isScaleEnable = true
        
        let pageView = DNSPageView(frame: CGRect(x: 0, y: ScreenInfo.StatusBarHeght, width: ScreenInfo.Width, height: ScreenInfo.Height), style: style, titles: titleAarry, childViewControllers: viewControllerArray)
        
        view.addSubview(pageView)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


