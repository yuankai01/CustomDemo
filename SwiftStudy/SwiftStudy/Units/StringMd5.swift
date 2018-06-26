//
//  StringMd5.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/24.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import Foundation

/*
 #pragma mark - Helpers
 - (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
 {
 NSMutableString *mutableString = @"".mutableCopy;
 for (int i = 0; i < length; i++)
 [mutableString appendFormat:@"%02x", bytes[i]];
 return [NSString stringWithString:mutableString];
 }
 
 - (NSString *)md5String
 {
 const char *string = self.UTF8String;
 int length = (int)strlen(string);
 unsigned char bytes[CC_MD5_DIGEST_LENGTH];
 CC_MD5(string, length, bytes);
 return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
 }
*/
extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.init(allocatingCapacity: digestLen)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
    }
}

extension Dictionary {
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary:Dictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)

//        return JSONString!
        return JSONString! as String
    }
    
    /// JSONString转换为字典
    ///
    /// - Parameter jsonString: <#jsonString description#>
    /// - Returns: <#return value description#>
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        
        return NSDictionary()
    }
}

