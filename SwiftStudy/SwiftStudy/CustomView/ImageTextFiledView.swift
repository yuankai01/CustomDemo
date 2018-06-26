//
//  ImageTextFiledView.swift
//  SwiftLogin
//
//  Created by gao on 16/9/26.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class ImageTextFiledView: UITextField{

    var leftImgView = UIImageView.init()
    var normalImg = String.init()
    var highImg = String.init()
    
    var customRView: UIView!
    
    //第一个初始化方法
    init(frame: CGRect,image:String,highImage:String,line : Bool) {
        super.init(frame: frame)

        normalImg = image
        highImg = highImage
        
        let tempImage = UIImage.init(named: normalImg)
        
        leftImgView.frame = CGRect.init(x: 0, y: 0, width: tempImage!.size.width, height: tempImage!.size.height)
        leftImgView.image = tempImage
        self.leftView = self.leftImgView
        self.leftViewMode = UITextFieldViewMode.always
        
        if line {
            let lineLayer = CALayer.init()
            lineLayer.frame = CGRect.init(x: 0, y: self.height - 1, width: self.width, height: 1)
            lineLayer.backgroundColor = UIColor.lightGray.cgColor
            self.layer .addSublayer(lineLayer)
        }
        
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = kColorGray1
    }

    //第二个初始化方法
    
    convenience init(frame: CGRect,image:String,highImage:String,line : Bool,rightView: UIView?) {
        
        self .init(frame: frame,image:image,highImage:highImage,line : line)

        if  rightView != nil {
            
            rightView!.x = self.width - rightView!.width - 10
            
            customRView = rightView
            
            self .addSubview(customRView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:响应
    override func becomeFirstResponder() -> Bool {
        leftImgView.image = UIImage.init(named: highImg)
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        
        leftImgView.image = UIImage.init(named: normalImg)
        return super.resignFirstResponder()
    }
    
    func textMedtond() {
        
    }
    
    //MRAK: 重写父类方法
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
//        let clearRect = self.clearButtonRect(forBounds: bounds)
        
        if self.leftView != nil {
            return CGRect.init(x: self.leftView!.maxX + 10, y: rect.origin.y, width: rect.size.width - self.leftView!.maxX - 10, height: rect.size.height)
        }
        
        return super.editingRect(forBounds: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)

        if self.leftView != nil {
            return CGRect.init(x: self.leftView!.maxX + 10, y: rect.origin.y, width: rect.size.width - self.leftView!.maxX - 10, height: rect.size.height)
        }
        
        return rect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 10
        
        return leftViewRect
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        
        let  rect = super.clearButtonRect(forBounds: bounds)
        
        if customRView != nil{
            return CGRect.init(origin: CGPoint.init(x: customRView.x - 20 - 20, y: rect.origin.y), size: rect.size)
        }
        
        return rect
    }
    
}
