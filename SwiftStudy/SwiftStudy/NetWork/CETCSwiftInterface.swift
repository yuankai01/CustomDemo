//
//  CETCSwiftInterface.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/10/17.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit
import Alamofire

class CETCSwiftInterface: NSObject {

    let name: String
    init(name: String) { self.name = name }
    
    func testLogObjec(obj:String) -> Void {
        NSLog("这是一swift 的log:%@", obj)
    }
   
    func swiftAlert(str:String){
//        CETCAlertView.showMessage(str)
        
        Alamofire.request("http://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0").responseJSON
            { (response) in
                
                print("response ==== \(response)")
        }
    }
    
    func amifleTest() -> Void {
//        Alamofire.request(URLRequest());
        
        Alamofire.request("http://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0").responseJSON
            { (response) in
                print(response)
        }
        
//        Alamofire.
        
//        Alamofire.request(.GET, "http://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0").responseJSON {
//            (response)   in
//
//            // 有错误就打印错误，没有就解析数据
//            if let Error = response.result.error
//            {
//                print(Error)
//            }
//            else if let jsonresult = response.result.value {
//                // 用 SwiftyJSON 解析数据
//                let JSOnDictory = JSON(jsonresult )
//                let data =  JSOnDictory["data"]["items"].array
//
//                //print(jsonresult)
//
//            }
//        }
    }
}


