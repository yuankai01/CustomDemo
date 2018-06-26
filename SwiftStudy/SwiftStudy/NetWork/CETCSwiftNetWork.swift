//
//  CETCSwiftNetWork.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/22.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CETCSwiftNetWork: NSObject {
    
    //网络请求回调 闭包
    /**
     *   post方式获取数据
     *   url : 请求地址
     *   params : 传入参数
     *   success : 请求成功回调函数
     *   fail : 请求失败回调函数
     */
    func post(url : String,params : [String : Any], success: @escaping (_ json:Any) -> Void,fail: @escaping (Any) -> Void) -> Void {
        
        /*
         *  请求格式： {
         check = 67808a3786b1759a4229499a2b33dfc7;
         json = "{\"userSessionId\":\"eb57ce4fba2011eb2722b3bf56eb05ef\",\"planType\":\"1\",\"userId\":\"11778\",\"pageSize\":\"10\",\"pageNum\":\"1\"}";
         }
        */
        
        /*
         1、将params转成string;
         2、将转换后的string后面追加字符串“123456”后进行md5加密；
         3、添加请求字段：json:转换后的string,check:md5加密字符串。
         */
        
        /*    "123456"可以为服务端和客户端商定好的任意字符串
         1、服务器拿到客户端传过去的JSON字符串,取“json”字段，得到请求参数strJson后，后面添加字符串"123456"，进行md5加密，得到ServerMD5；
         2、服务器拿到客户端传过去的JSON字符串,取“check”字段，得到客户端加密后的字段ClienMD5;
         3、最后对ServerMD5和ClienMD5进行比较验证：如果一样则通过；如果不一样，则说明不是客户端和服务器的约定模式加密，说明是恶意请求，主要原因就是后面追加的匹配字符串（"123456"）第三方不知道是多少。（注意：由于每次登录服务器返回的sessionID不一样，会导致strjson经过md5加密后结果不一样）
         */
        
        //请求参数转换成NSString后，添加客户端和服务端约定好的字符串，然后进行md5加密
        //法1 oc md5加密 调取的是NSString扩展的md5方法。注意：将getJSONStringFromDictionary返回参数改成NSString
//        let strJson = params.getJSONStringFromDictionary(dictionary: params)
//        let checkStr = NSString.init(format: "%@%@", strJson,"123456")
//        let checkMD5 = checkStr.md5
        
        //法2 swift md5加密 调取的是String扩展的md5()
        let strJson = params.getJSONStringFromDictionary(dictionary: params)
        let checkStr = strJson + "123456"
        
        let checkMD5 = checkStr.md5()
        
        var requestDic = [String : Any]()
        requestDic["json"] = strJson
        requestDic["check"] = checkMD5
        
//        print("requestDic ===\n \(requestDic.getJSONStringFromDictionary(dictionary: requestDic))")
        
        Alamofire.request(url, method: .post, parameters: requestDic, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            
            print("\nRequestUrl === : \(url) \nRequestJsonStr ==== :\n \(strJson)\n")

            // original server data as UTF8 string。utf8Text是json字符串，可以用json工具打开
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Response json string === :\n\(JSON(utf8Text))")
                
                //解析utf8Text 不出来？？？？
//                let JsonDictory = JSON(utf8Text)   //SwiftyJSON json解析
//                let resCode = JsonDictory["json"]["respCode"]
//                print("resCode ===--== \(resCode)") //空的
            }

            //判断返回成功与否
            switch response.result.isSuccess
            {
            case true:
                if let value = response.result.value
                {
                    let JsonDictory = JSON(value)   //SwiftyJSON json解析
                    let resCode = JsonDictory["json"]["respCode"]
                    switch resCode {
                    case "0000":
                        let result = JsonDictory["json"]["data"]
                        print("suceeeeeee111==:\n\(result)")
                        success(result)
                    default:
                        let msg = JsonDictory["json"]["respDesc"]
                        print("message === \(msg)")
                        break
                    }
                }
                
                break
            case false:
                print("error === : \(String(describing: response.result.error))")
                fail(response.result.error as Any)
                break
            }
        })
    }
    
    //MARK:上传图片
    func uploadImages(image : UIImage,url : String,progressdd:@escaping(Any?) -> Void,succes : @escaping(Any?) -> Void,fail : @escaping(Any?) -> Void) -> Void {
        
        let imageData = UIImagePNGRepresentation(image)!
        
        Alamofire.upload(imageData, to: "https://httpbin.org/post").uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON { response in
            succes(response)
        }
    }
    
    //MARK:上传文件
    func uploadFile(filePath:URL,progressdd:@escaping(Any?) -> Void,succes : @escaping(Any?) -> Void,fail : @escaping(Any?) -> Void) -> Void {
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")

        Alamofire.upload(fileURL!, to: "https://httpbin.org/post").uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            progressdd(progress.fractionCompleted)
        }).response { (response) in
            succes(response)
        }
    }
    
    //MARK:多表单任务上传
    func uploadMuilte(userInfo : [String : Any]) -> Void {
        Alamofire.upload(multipartFormData: { (multipartFormData) in

//            multipartFormData.appendBodyPart(data: String(userInfo["id"] as! Int).dataUsingEncoding(UTF8)!, name: "userId")
//            multipartFormData.appendBodyPart(data: Data, name: "file", fileName: "fileName", mimeType: "image/png")
//            multipartFormData.append(unicornImageURL, withName: "unicorn")
//            multipartFormData.append(rainbowImageURL, withName: "rainbow")

        }, to: "https://httpbin.org/post") { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    //MARK:测试网络
    func requestLearnPlan() -> Void {
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        let parameters: Parameters = [
            "foo": "bar",
            "baz": ["a", 1],
            "qux": [
                "x": 1,
                "y": 2,
                "z": 3
            ]
        ]
        
        let paradd:Parameters = [
            "fsf":"bar",
            "bardf":"dfa",
            "dfsd": ""
        ]
        
        Alamofire.request("", method: .post, parameters: paradd, encoding: URLEncoding.default)
        
        
        //5个参数 <#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>
        // All three of these calls are equivalent
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: URLEncoding.default)
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }
}

/* 注释
 error === : Optional(Error Domain=NSURLErrorDomain Code=-1022 "
 后来发现为题所在 由于iOS9以后,需要App的网络协议里面都必须使用HTTPS协议!
 iOS开发中依然使用http请求，而非https请求，必须要专门设置一下plist：
  添加App Transport Security Settings, 展开后输入Allow Arbitrary Loads，值改成YES
 */
