//
//  ColorConst.swift
//  SwiftLogin
//
//  Created by gao on 16/9/28.
//  Copyright © 2016年 Gao. All rights reserved.
//

import Foundation
import UIKit

//rgb颜色转换
func RGB(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
    
    return RGBA(r: red, g: green, b: blue, a: 1)
}

func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

//十六进制函数 颜色转换
func HexColor (_ hexColor:NSString)->UIColor{
    
    return HexColorA(hexColor, 1)
}

func HexColorA(_ hexColor:NSString,_ alpha:CGFloat) -> UIColor {
    var str = hexColor.trimmingCharacters(in: CharacterSet.whitespaces)
    if str .contains("#") {
        //        str .replacingOccurrences(of: "#", with: "")
        str = (str as NSString).substring(from: 1)
    }
    
    let red = (str as NSString ).substring(to: 2)
    let green = (str as NSString).substring(with: NSMakeRange(2, 2))
    let blue = (str as NSString).substring(with: NSMakeRange(4, 2))
    
    var r:UInt32 = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    
    Scanner.init(string: red).scanHexInt32(&r)
    Scanner.init(string: green).scanHexInt32(&g)
    Scanner.init(string: blue).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
}

//MARK:系统颜色
let kColorSystem_Black = UIColor.black
let kColorSystem_Blue = UIColor.blue
let kColorSystem_Brown = UIColor.brown
let kColorSystem_Cyan = UIColor.cyan
let kColorSystem_Clear = UIColor.clear

let kColorSystem_DarkGray = UIColor.darkGray
let kColorSystem_DarkText = UIColor.darkText
let kColorSystem_Gray = UIColor.gray
let kColorSystem_Green = UIColor.green
let kColorSystem_LightGray = UIColor.lightGray

let kColorSystem_LightText = UIColor.lightText
let kColorSystem_Magenta = UIColor.magenta
let kColorSystem_Orange = UIColor.orange
let kColorSystem_Purplek = UIColor.purple
let kColorSystem_Red = UIColor.red

let kColorSystem_White = UIColor.white
let kColorSystem_Yellow = UIColor.yellow

//MARK: 自定义颜色
let kColorBlue1 = HexColor("#415065")   //主色
let kColorBlue2 = HexColor("68778c")   //辅助 多用于实底可用按钮 小伊下拉菜单中下划线颜色

let kColorGray1 = HexColor("565656")  //文字主色
let kColorGray2 = HexColor("a8a8a8")  //辅助文字 多用于不可点击按钮或未选中标签
let kColorGray3 = HexColor("cdcdcd")  //线条颜色 首页进度条颜色
let kColorGray4 = HexColor("f1f1f1")  //淡灰背景颜色 首页进度条背景颜色

let kColorRed1 =  HexColor("9d2932")   //提示文字
let kColorRed2 =  HexColor("b36d61")   //辅助 功能文字 图表用色
let kColorRed3 =  HexColor("c69188")   //辅助 小伊否定选项用色
let kColorRed4 =  HexColor("d3bda8")   //辅助 首页详情按钮用色
let kColorRed5 =  HexColor("f4756e")   //新报告弹出按钮用色

let kColorOrange1 = HexColor("fabc59")   //图表用色
let kColorOrange2 = HexColor("ffd593")   //图表用色

let kColorGreen = HexColor("748e5e")   //提示文字
let kColorWhite = HexColor("ffffff")   //按钮白色文字
let kColorSpiderFill = HexColor("77b0fc")

		
