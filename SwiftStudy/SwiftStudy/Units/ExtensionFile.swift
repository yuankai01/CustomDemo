//
//  ExtensionFile.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/24.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

extension UIColor {
    //返回随机颜色
    open class var randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random() % 256)/255.0
            let green = CGFloat(arc4random() % 256)/255.0
            let blue = CGFloat(arc4random() % 256)/255.0
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

extension UIImageView {
    
    func setImageUrl(_ string : String?) -> Void {
        if(string != nil){
            let url = URL(string: string!)!
            self.af_setImage(withURL: url)
            
//        self.af_setImage(withURL: <#T##URL#>, placeholderImage: <#T##UIImage?#>, filter: <#T##ImageFilter?#>, progress: , progressQueue: <#T##DispatchQueue#>, imageTransition: <#T##UIImageView.ImageTransition#>, runImageTransitionIfCached: <#T##Bool#>, completion: <#T##((DataResponse<UIImage>) -> Void)?##((DataResponse<UIImage>) -> Void)?##(DataResponse<UIImage>) -> Void#>)
        }
    }
    
    func setImageUrl(_ stringUrl : String?, _ placeholderImage : String?) -> Void {

        if let count = stringUrl?.count,count > 0 {
            let url = URL.init(string: stringUrl!)
            let image = UIImage.init(named: placeholderImage!)!
            self.af_setImage(withURL: url!, placeholderImage: image)
        }
    }

//    func setImageUrl(_ stringUrl : String?,
//                     _ placeholderImage : String?,
//                     _ completion: UIImage) -> Void {
//        let url = URL.init(string: stringUrl!)!
//        let image = UIImage.init(named: placeholderImage!)!
////        let completionImg = <#value#>
//
//
////        self.af_setImage(withURL: url, placeholderImage: image, completion: completion)
//    }
}

