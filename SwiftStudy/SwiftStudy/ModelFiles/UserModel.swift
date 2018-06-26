//
//  UserModel.swift
//  SwiftStudy
//
//  Created by gao on 2018/6/21.
//  Copyright © 2018年 gao. All rights reserved.
//
/* <#注释#>
 Swift中的单例非常简单，往小了说，用 let 去修饰，写在类外，就是一个全局可用的单例。
 如果想要像OC一样写一个单例类，也非常的简单，如下
 */

import UIKit

//单例类
import UIKit
//仿OC写法
class UserModel: NSObject {
    var userId: String?
    var userSessionKey: String?
    
    static let shareUser: UserModel = UserModel()
    class func sharedUserModel() -> UserModel {
        return shareUser
    }
}
//简便写法
class danli2 {
    static let `default` = UserModel()
}

/*
 作者：跷脚啖牛肉
 链接：https://www.jianshu.com/p/3796886b4953
 Swift中安全优雅的使用UserDefaults
 */
struct UserDefaultKeys {
    // 账户信息
    struct AccountInfo {
        let userName = "userName"
        let avatar = "avatar"
        let password = "password"
        let gender = "gender"
        let age = "age"
    }
    // 登录信息
    struct LoginInfo {
        let token = "token"
        let userId = "userId"
    }
    // 配置信息
    struct SettingInfo {
        let font = "font"
        let backgroundImage = "backgroundImage"
    }
}

