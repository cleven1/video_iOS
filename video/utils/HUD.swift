//
//  CRMBProgressHUD.swift
//  iTour
//
//  Created by user on 29/12/17.
//  Copyright © 2017年 cleven. All rights reserved.
//

import UIKit
import MBProgressHUD


@objcMembers
public class HUD:NSObject {
    
    public static let hudShowTime = 1.5
    static var hud : MBProgressHUD?
    //MARK:自定义view显示
    fileprivate class func createHud(view : UIView? = UIApplication.shared.keyWindow, isMask : Bool = false) -> MBProgressHUD? {
        guard let supview = view ?? UIApplication.shared.keyWindow else {return nil}
        let HUD = MBProgressHUD.showAdded(to: supview
            , animated: true)
        HUD.frame = CGRect(x: 0, y: ScreenInfo.navigationHeight, width: ScreenInfo.Width, height: ScreenInfo.Height - ScreenInfo.navigationHeight)
        HUD.animationType = .zoom
        if isMask {
            HUD.backgroundView.color = UIColor(white: 0.0, alpha: 0.4)
        } else {
            HUD.backgroundView.color = UIColor.clear
            HUD.bezelView.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
            HUD.contentColor = UIColor.white
        }
        HUD.removeFromSuperViewOnHide = true
        HUD.show(animated: true)
        return HUD
    }
    
    //MARK:自定义view显示
    fileprivate class func showHudTips (message : String?, icon : String?, view : UIView?, completeBlock : (()->(Void))?) {
        let hud = self.createHud(view: view, isMask: false)
        hud?.label.text = message
        hud?.label.numberOfLines = 0
        if let icon = icon {
            hud?.customView = UIImageView.init(image: UIImage.init(named: icon))
        }
        hud?.mode = .customView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hudShowTime) {
            hud?.hide(animated: true)
            
            guard let completeBlock = completeBlock else {
                return
            }
            completeBlock()
        }
        
    }
}

extension HUD {
    //MARK:加载提示框
    public class func showLoadingHudView (view : UIView? = UIApplication.shared.keyWindow ,message:String?, isMask : Bool = false){
        let hud = self.createHud(view: view, isMask: isMask)
        hud?.mode = .indeterminate
        hud?.label.text = message
        self.hud = hud
    }
    public class func showLoadingHudInView (view : UIView? = UIApplication.shared.keyWindow ,message:String?, isMask : Bool = false) -> MBProgressHUD?{
        let hud = self.createHud(view: view, isMask: isMask)
        hud?.mode = .indeterminate
        hud?.label.text = message
        self.hud = hud
        return hud
    }
    
    //MARK:提示文字
    public class func showTextHudTips (message : String?, view : UIView? = UIApplication.shared.keyWindow , isMask : Bool = false,afterDelay:Double = hudShowTime){
       _ = showTextHud(message: message, view: view, isMask: isMask, afterDelay: afterDelay)
    }
    
    public class func showTextHud (message : String?, view : UIView? = UIApplication.shared.keyWindow , isMask : Bool = false,afterDelay:Double = hudShowTime) -> MBProgressHUD? {
        let hud = createHud(view: view, isMask: isMask)
        hud?.mode = .text
        hud?.detailsLabel.font = UIFont.systemFont(ofSize: 16.0)
        hud?.detailsLabel.text = message
        hud?.hide(animated: true, afterDelay: afterDelay)
        return hud
    }
    
    //MARK:成功后提示
    public class func showSuccesshTips (message : String?, view : UIView? = UIApplication.shared.keyWindow ,afterDelay:Double = hudShowTime) {
        self.showHudTips(message: message, icon: "mb_success_tips", view: view, completeBlock: nil)
    }
    public class func showSuccesshTips (message : String?, view : UIView? = UIApplication.shared.keyWindow , completeBlock : (()->(Void))?) {
        self.showHudTips(message: message, icon: "mb_success_tips", view: view, completeBlock: completeBlock)
    }
    //MARK:失败后提示
    public class func showErrorMessage(message : String?, view : UIView? = UIApplication.shared.keyWindow ){
        self.showHudTips(message: message, icon: "mb_error_tips", view: view, completeBlock: nil)
    }
    
    public class func showErrorMessage (message : String?, view : UIView? = UIApplication.shared.keyWindow , completeBlock : (()->(Void))?) {
        self.showHudTips(message: message, icon: "mb_error_tips", view: view, completeBlock: nil)
    }
    
    //MARK:隐藏提示框
    public class func hideHud () {
        guard let hud = hud else {
            return
        }
        hud.hide(animated: true)
        self.hud = nil
    }
}

