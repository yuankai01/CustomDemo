//
//  RegisterForgetView.swift
//  SwiftLogin
//
//  Created by gao on 16/10/14.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON

enum ViewType {
    case RegisterView
    case ForgetView
}

//声明一个代理协议
@objc protocol RegisterForgetDelegate {
    
    func sureParames(paramesDic:NSDictionary)
    
   @objc optional func agreement()
   @objc optional func backLogin()
}

class RegisterForgetView: UIView, UITextFieldDelegate{

    var phoneTF: ImageTextFiledView!
    var codeTF: ImageTextFiledView!
    var passwordTF: ImageTextFiledView!
    var agreeBtn: UIButton!
    
    var parseFile: ParseFile?

    weak var delegate: RegisterForgetDelegate!
    
    init(frame: CGRect,viewType: ViewType) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        phoneTF = ImageTextFiledView.init(frame: CGRect.init(x: 0, y: 20, width: self.width, height: 40), image: "icon_9", highImage: "icon_10", line: true)
        phoneTF.placeholder = "请输入手机号码"
        phoneTF.keyboardType = UIKeyboardType.numberPad
        phoneTF.delegate = self
        self .addSubview(phoneTF)
        
        let sendBtn = UIButton.init(type: UIButtonType.custom)
        sendBtn.frame = CGRect.init(x: 0, y: 5, width: 80, height: 30)
        sendBtn.setTitle("发送验证码", for: UIControlState.normal)
        sendBtn.addTarget(self, action: #selector(sendCode), for: UIControlEvents.touchUpInside)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sendBtn.setTitleColor(kColorRed2, for: UIControlState.normal)
        sendBtn.showsTouchWhenHighlighted = true
        sendBtn.layer.cornerRadius = 5
        sendBtn.layer.borderColor = kColorRed2.cgColor
        sendBtn.layer.borderWidth = 1
        
        codeTF = ImageTextFiledView.init(frame: CGRect.init(x: phoneTF.x, y: phoneTF.maxY + 10, width: phoneTF.width, height: phoneTF.height), image: "icon_11", highImage: "icon_12", line: true, rightView: sendBtn)
        codeTF.placeholder = "请输入验证码"
        codeTF.keyboardType = UIKeyboardType.numberPad
        codeTF.delegate = self
        self .addSubview(codeTF)
        
        //eyeBtn
        let eyeBtn = UIButton.init(type: UIButtonType.custom)
        eyeBtn.frame = CGRect.init(x: 0, y: 5, width: 30, height: 30)
        eyeBtn.setImage(UIImage.init(named: "icon_13"), for: UIControlState.normal)
        eyeBtn.setImage(UIImage.init(named: "icon_14"), for: UIControlState.selected)
        eyeBtn .addTarget(self, action: #selector(showPassword(button:)), for: UIControlEvents.touchUpInside)
        
        passwordTF = ImageTextFiledView.init(frame: CGRect.init(x: codeTF.x, y: codeTF.maxY + 10, width: codeTF.width, height: codeTF.height), image: "icon_7", highImage: "icon_8", line: false, rightView: eyeBtn)
        passwordTF.isSecureTextEntry = true;
        passwordTF.placeholder = "请输入密码"
        passwordTF.delegate = self
        self .addSubview(passwordTF)
        
        let sureBtn = UIButton.init(frame: CGRect.init(x: 0, y: passwordTF.maxY, width: passwordTF.width, height: passwordTF.height))
        sureBtn.backgroundColor = kColorBlue1
        sureBtn.setTitle("确定", for: UIControlState.normal)
        sureBtn.showsTouchWhenHighlighted = true
        self .addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(sureBtnPress(button:)), for: UIControlEvents.touchUpInside)
        
        switch viewType {
        case .RegisterView:     //注册界面增加内容
            let checkBtn = UIButton.init(type: UIButtonType.custom)
            checkBtn.frame = CGRect.init(x: sureBtn.x, y: sureBtn.maxY + 5, width: 20, height: 20)
//            checkBtn.isSelected = true
            checkBtn.setImage(UIImage.init(named: "btn_check_finish"), for: UIControlState.normal)
            checkBtn.setImage(UIImage.init(named: "btn_check"), for: UIControlState.selected)
            checkBtn.addTarget(self, action: #selector(checkBtnPress(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(checkBtn)
            
            //同意协议
            agreeBtn = UIButton.init(type: UIButtonType.custom)
            agreeBtn.frame = CGRect.init(x: checkBtn.maxX + 5, y: checkBtn.y, width: 200, height: checkBtn.height)
            agreeBtn.setTitle("同意协议", for: UIControlState.normal)
            agreeBtn.setTitleColor(kColorBlue1, for: UIControlState.normal)
            agreeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            agreeBtn.addTarget(self, action: #selector(agreementBtnPress), for: UIControlEvents.touchUpInside)
            self.addSubview(agreeBtn)
            
            //账号登录
            let loginBtn = UIButton.init(type: UIButtonType.custom)
            loginBtn.frame = CGRect.init(x: self.width - 100, y: agreeBtn.y, width: 100, height: agreeBtn.height)
            loginBtn.setTitle("账号登录", for: UIControlState.normal)
            loginBtn.titleLabel?.font = agreeBtn.titleLabel?.font
            loginBtn.setTitleColor(kColorBlue1, for: UIControlState.normal)
            loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            loginBtn.addTarget(self, action: #selector(loginBtnPress), for: UIControlEvents.touchUpInside)
            self.addSubview(loginBtn)
            break
        case .ForgetView:
            
            break
        }
        
        parseFile = ParseFile.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //显示隐藏密码
    @objc func showPassword(button:UIButton) {
        let tempPassword = String.init(passwordTF.text!)
        passwordTF.text = ""
        passwordTF.text = tempPassword
        
        passwordTF.isSecureTextEntry = button.isSelected
        button.isSelected = !button.isSelected
    }
    /*
     {
         code = 0;
         message = "<null>";
         result =     {
             list =
             (
                 {
                     id = 7020000;
                     imageUrl = "http://paopao.nosdn.127.net/72268a8a-3250-43a4-9403-e8ffe71ad8ff";
                     subTitle = "\U5b8c\U7f8e\U8eab\U6750\U7a7f\U51fa\U6765";
                     title = "\U3010\U7a7f\U642d\U5efa\U8bae\U3011\U6781\U7b80\U98ce\U683c ";
                 },
                 {
                     id = 4474566;
                     imageUrl = "http://paopao.nosdn.127.net/fd113fae-d1d5-4962-89f0-e0bfa7444fc8";
                     subTitle = "\U4e0d\U7ba1\U600e\U4e48\U7a7f \U914d\U8fd0\U52a8\U978b\U624d\U65f6\U9ae6";
                     title = "\U3010\U8fd0\U52a8\U5355\U54c1\U3011\U79cb\U51ac\U65b0\U98ce\U5c1a";
                 }
             );
         };
     }
     */
    //buttonPress
    @objc func sendCode() -> Void {

//        //创建URL对象
//        let url = URL(string:"http://www.hangge.com/getJsonData.php")!
//
//        Alamofire.request(url).validate().responseJSON { response in
//            switch response.result.isSuccess {
//            case true:
//                if let value = response.result.value {
//                    let testJson = JSON(value)
//                    if let number = testJson[0]["phones"][0]["number"].string {
//                        // 找到电话号码
//                        print("第一个联系人的第一个电话号码：",number)
//                    }
//                }
//            case false:
//                print(response.result.error)
//            }
//        }

        parseFile?.parseLocJsonFile()
        
        
        Alamofire.request("http://m.paopao.163.com/m/v2/getDiscover", method: .post, parameters: nil)
            .responseJSON { response in
                
                if let value = response.result.value
                {
                    print(value)

                    /*
                     {
                     code = 0;
                     message = "<null>";
                     result =     {
                         list =
                         (
                         {
                         id = 7020000;
                         imageUrl = "http://paopao.nosdn.127.net/72268a8a-3250-43a4-9403-e8ffe71ad8ff";
                         subTitle = "\U5b8c\U7f8e\U8eab\U6750\U7a7f\U51fa\U6765";
                         title = "\U3010\U7a7f\U642d\U5efa\U8bae\U3011\U6781\U7b80\U98ce\U683c ";
                         },
                         {
                         id = 4474566;
                         imageUrl = "http://paopao.nosdn.127.net/fd113fae-d1d5-4962-89f0-e0bfa7444fc8";
                         subTitle = "\U4e0d\U7ba1\U600e\U4e48\U7a7f \U914d\U8fd0\U52a8\U978b\U624d\U65f6\U9ae6";
                         title = "\U3010\U8fd0\U52a8\U5355\U54c1\U3011\U79cb\U51ac\U65b0\U98ce\U5c1a";
                         }
                         );
                         };
                     }
                     */

//                  let dic =  JSON.init(value)
                    
                    
                    
//                    let list = JSON["result"]
//                    let list2 = JSON.objectForKey["result"]

                    
                    //要转换成NSDictionary才可以用objecForKey取值
                    
//                    let list = JSON.objec
                }
        }
        
    }
    
//    - func alamofireRequest(){
//        -         var model:TableViewCellModel!
//        -         //Alamofire的异步问题
//            -         Alamofire.request(.GET, "http://m.paopao.163.com/m/v2/getDiscover", parameters: ["foo": "bar"])
//            -             .responseJSON { response in
//            -                 if let JSON = response.result.value {
//            -                     if let json = JSON.objectForKey("result")?.objectForKey("list"){
//            -                         self.num = json.count
//            -                         for var i = 0; i<json.count; i = i + 1{
//            -                             let str1 = json[i].objectForKey("title")as! String
//            -                             let str2 = json[i].objectForKey("subTitle")as! String
//            -                             let str3 = json[i].objectForKey("imageUrl")as! String
//            -                             model = TableViewCellModel(titleName: str1, subTitleName: str2, imageUrlName: str3)
//            -                             self.item.append(model)
//            -                         }
//            -                         //调用代理方法
//            -                         self.delegate?.changeJson(self.item)
//            -                     }
//            -                 }
//            -         }
//        -     }
    
    @objc func sureBtnPress(button:UIButton) {
        let muDic = NSMutableDictionary.init()
        
        self.delegate .sureParames(paramesDic: muDic)
    }
    
    @objc func checkBtnPress(button:UIButton) -> Void {
        button.isSelected = !button.isSelected
    }
    
    @objc func agreementBtnPress() -> Void {
        self.delegate .agreement!()
    }
    
    @objc func loginBtnPress()
    {
        self.delegate.backLogin!()
    }
    
    //隐藏键盘
    func registerAllTextField() {
        phoneTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        codeTF.resignFirstResponder()
    }
    
    //MARK:textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField .isEqual(phoneTF) && range.location > kLengthPhone - 1{
            return false
        }
        
        if textField.isEqual(codeTF) && range.location > 5 {
            return false
        }
        
        if textField.isEqual(passwordTF) && range.location > kLengthPassword - 1 {
            return false
        }
        
        return true
    }
}
