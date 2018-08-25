//
//  UINavigationController+Extension.swift
//  video
//
//  Created by cleven on 2018/8/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

// 添加全局返回手势
extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        print(systemGes)
        // 获取系统手势添加的view
        guard let gesView = systemGes.view else { return }
        
        // 获取Target和Action，但是系统并没有暴露相关属性
        //利用 class_copyIvarList 查看所有的属性 (发现_targets 是一个数组)
        print("------------------------属性---------------------------------")
        var ivarCount : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &ivarCount)!
        for i in 0..<ivarCount {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        print("------------------------方法---------------------------------")
        //利用 class_copyMethodList 查看所有的方法（并没有找到我们想要的方法）
        var methodCount : UInt32 = 0
        let methods = class_copyMethodList(UIGestureRecognizer.self, &methodCount)!
        
        for i in 0 ..< methodCount {
            let method = methods[Int(i)]
            let name = method_getName(method)
            print("\(name)")
        }
        //从Targets 取出 Target
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        //方法名称获取 Action
        let action = Selector(("handleNavigationTransition:"))
        
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}
