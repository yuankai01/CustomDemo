//
//  GlobalConst.swift
//  SwiftLogin
//
//  Created by gao on 16/6/14.
//  Copyright © 2016年 GaoHF. All rights reserved.
//

import UIKit

//MARK:- 简单宏 直接声明常亮就可以了
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let kFitWidth = UIScreen.main.bounds.width / 375
let kFitHiehgt = UIScreen.main.bounds.height / 667

let kLengthPhone = NSInteger.init(11)
let kLengthPassword = NSInteger.init(18)


func kScaleWidth(width : CGFloat) ->CGFloat
{
    return width * UIScreen.main.bounds.width / 375
}

func kScaleHeight(height : CGFloat) ->CGFloat
{
    return height * UIScreen.main.bounds.height / 667
}

//MARK:- 复杂宏 用函数定义
func x(_ obj : UIView) ->CGFloat{
    return obj.frame.origin.x
}

        
