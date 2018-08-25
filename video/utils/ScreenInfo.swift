//
//  ScreenInfo.swift
//  iTour
//
//  Created by cleven on 2017/12/6.
//  Copyright © 2017年 Croninfo. All rights reserved.
//

import UIKit

struct ScreenInfo {
    
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let Scale = Width / 375
    static let StatusBarHeght: CGFloat = statusBarHeight()
    static let navigationHeight:CGFloat = navBarHeight()
    static let tabBarHeight:CGFloat = tabBarrHeight()
    static let Kmargin_15:CGFloat = 15
    static let Kmargin_10:CGFloat = 10
    static let Kmargin_5:CGFloat = 5
    static let kMaxW:CGFloat = 280
    static let kMargin_20:CGFloat = 20
    static let kBtnH:CGFloat = 40
    static let kTextFieldH:CGFloat = 40
    static let kLoginFontSize:CGFloat = 16
    static let kOtherFontSize:CGFloat = 14
    static let kTFLeftW:CGFloat = 30
    static let kTFLeftH:CGFloat = 20
    
    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64;
    }
    static private func tabBarrHeight() -> CGFloat {
        return isIphoneX() ? 83 : 49;
    }
    static private func statusBarHeight() -> CGFloat{
        return isIphoneX() ? 44 : 20
    }    
}
