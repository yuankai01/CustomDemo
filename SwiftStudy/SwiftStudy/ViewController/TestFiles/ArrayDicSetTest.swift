//
//  ArrayDicSetTest.swift
//  SwiftLogin
//
//  Created by gao on 16/10/21.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit
import Foundation

/* swift 声明数组 的三种写法有什么不同？
 var users: [Users] = [] ， var adminUsers = [Users]()，var mapperUsers: [Users]?
 https://www.zhihu.com/question/53020783/answer/133081305
 
 官方推荐第一种。能用literal的尽量使用literal。同理：
 let names: Set<String> = []
 
 前两种效果一样的吧，第一种显式声明了类型，第二种type inference 推导出类型。简单类型我倾向于第二种写法，看起来更清爽。只是类型推导在判断一些复杂类型时，有些坑，Xcode甚至会假死，需要显式声明类型来避开。第三种类型就不一样了，是optional。
  */

class ArrayDicSetTest: NSObject {

    //创建时 没有自动生成 要手动写个初始化方法，方便调用
    override init() {
        
    }
    
    func arrayMethod() -> Array<Any> {
        
        let array = Array<Any>()
//        let array2 = Array.init(objects: "123",12,"adfa")
        
        print(array)
        
        return array
    }
    
    func dictionaryMethod() -> Dictionary<String, Any> {
        
        let dic33 = Dictionary<String, Any>()

//        let dic2 = Dictionary.init(objects: ["key1","key2"], forKeys: ["value1" as NSCopying,"value2" as NSCopying])
//        print(dic2)
        
  
        // 简写
        var dic:Dictionary = ["swiftKey":"swift"]
        
//        let adad = dic.object(forKey: "swift")

        // 例子
        var dic123 = NSDictionary(objects: ["张三","OC"], forKeys: ["name" as NSCopying,"OCKey" as NSCopying])

        return dic
    }
    
    func dictinaryMethod22() -> Void {
//        let dic = Dictionary.init()
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        let ddd = airports["XYZ"]
    }
    
    func dictionaryArrayMethod() -> Array<Any> {
     
        let array = Array<Any>.init()
        
        return array
    }
    
    
    func setMethod() -> Set<String> {
        
        let set = Set<String>.init()
        
        return set
    }
   
}
