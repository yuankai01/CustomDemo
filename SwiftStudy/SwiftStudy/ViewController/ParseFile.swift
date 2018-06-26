//
//  ParseFile.swift
//  SwiftLogin
//
//  Created by gao on 16/10/24.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class ParseFile: NSObject {
    
    override init() {
        
    }
    
    //MARK:解析本地文件
    func parseJsonFile() -> Void {
        
        let path = Bundle.main.path(forResource: "jsonTest", ofType: "json")
        let url = URL.init(fileURLWithPath: path!)
        
        do {
            let data = try Data.init(contentsOf: url)
            //            let json = try JSONSerialization
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            print(json)
            let jsonDic = json as! NSDictionary
            
            let list = jsonDic["list"] as! NSArray
            print(list)
            
            let obj1 = list.object(at: 1)
            print(obj1)
            
            let type = jsonDic["type"]
            
        } catch  {
            
        }
    }
    
    func parseLocJsonFile() -> Void {
        let path = Bundle.main.path(forResource: "jsonTest2", ofType: "json")
        let url = URL.init(fileURLWithPath: path!)
        
        do {
            let data = try Data.init(contentsOf: url)
            
            let jsonDic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let list = jsonDic["list"] as! NSArray
            
            
        } catch  {
            
        }
    }
    
    
}
