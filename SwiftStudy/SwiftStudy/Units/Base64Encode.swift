//
//  Base64Encode.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/12/4.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import Foundation

/**
 *   编码
 */
func base64Encoding(plainString:String)->String
{
    let plainData = plainString.data(using: String.Encoding.utf8)
    let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
    return base64String!
}

/**
 *   解码
 */
func base64Decoding(encodedString:String)->String
{
    let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
    let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
    return decodedString
}
