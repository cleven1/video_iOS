//  CLRootViewController.swift
//  video
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 admin. All rights reserved.
//
import UIKit

class CLRootViewController: UIViewController {
    
    
    var finished:((_ str:String)->())?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back_image").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(self.clickBackButton))
    }
    
    @objc public func clickBackButton(){
        navigationController?.popViewController(animated: true)
    }
}
