//
//  ArrayDicSetTest.swift
//  SwiftLogin
//
//  Created by gao on 16/10/21.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit
import Foundation

class ArrayDicSetTest: NSObject {

    //创建时 没有自动生成 要手动写个初始化方法，方便调用
    override init() {
        
    }
    
    func arrayMethod() -> NSArray {
        
        let array = NSArray.init()
        let array2 = NSArray.init(objects: "123",12,"adfa")
        
        print(array2)
        
        return array
    }
    
    func dictionaryMethod() -> NSDictionary {
        
        let dic33 = NSDictionary.init()

        let dic2 = NSDictionary.init(objects: ["key1","key2"], forKeys: ["value1" as NSCopying,"value2" as NSCopying])
        print(dic2)
        
  
        // 简写
        var dic:NSDictionary = ["swiftKey":"swift"]
        
        let adad = dic.object(forKey: "swift")

        // 例子
        var dic123 = NSDictionary(objects: ["张三","OC"], forKeys: ["name" as NSCopying,"OCKey" as NSCopying])

        return dic
    }
    
    func dictinaryMethod22() -> Void {
//        let dic = Dictionary.init()
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        let ddd = airports["XYZ"]
    }
    
    func dictionaryArrayMethod() -> NSArray {
     
        let array = NSArray.init()
        
        return array
    }
    
    
    func setMethod() -> NSSet {
        
        let set = NSSet.init()
        
        return set
    }
   
}
