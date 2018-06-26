//
//  CETCSwiftTestVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/29.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit

class CETCSwiftTestVC: CETCSwiftBaseVC {
    
    //声明属性 必须初始化赋值：空值或真实值
    var requestUrl: String = ""
    /*
     let requestUrl: String这样初始化字符串(Swfit2的写法)在swift3中报错，提示后加 = ""初始化值
     但是如果加init初始化方法的话，是可以的。
     如：    let name: String
     init(name: String) { self.name = name }
     注意：类继承NSObject，如CETCSwiftInterface类。
     */

    //初始化一个字符串属性
    var testString = String()
    //初始化一个可选的int类型,要用感叹号!解可选链
    var testInt : Int?
    //初始化一个整数类型 初始化值为1
    var numberOfRooms = 1
    //初始化一个数组NSArray
    var list1: NSArray = []
    var list2 = [] as NSArray
    //初始化一个数组Array
    var array1 = Array<Any>()
    var array2 : Array<Any>?
    var array3 = [] as Array
    //下面两种方法声明Array属性都报错误：Empty collection literal requires an explicit type
    //    var array2: Array = []
    //    var array3 = []
    
    var requestParams : [String : Any] = [:]
    
    //初始化一个Dictionary字典
    var dic1 = Dictionary<String, Any>()
    var dic2 : Dictionary<String, Any>? //初始化一个可选字典
    var dic3 = [:] as Dictionary
    //下面两种方法声明Array属性都报错误：Empty collection literal requires an explicit type
    //    var dic2 : Dictionary = [:]
    //    var dic4 = [:]
    
    //初始化一个NSDictionary字典
    var nsDic1 : NSDictionary = [:]
    var nsDic2 = [:] as NSDictionary
    
    //初始化一个集合 Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
    var letters = Set<Character>()
    //下面语句写在方法中
    //    letters.insert("a")
    // letters 现在含有1个 Character 类型的值
    //    letters = []
    // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
    
    //初始化一个有初始值的set集合
    var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
    
    //初始化一个类
    var netWork = CETCSwiftNetWork()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

/*
 ios swift 中nsobject不是所有类的父类
 ios swift中AnyObject才是所有类的父类搜索
 在ios中NSObject等objective-c中的类可以直接使用
 */
class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address : NSObject{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(String(describing: buildingNumber)) \(String(describing: street))"
        } else {
            return nil
        }
    }
}
