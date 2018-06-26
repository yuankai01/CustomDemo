//
//  ViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/9/23.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: LoginBgImageVC {

    var bgView = UIView.init()
    var nameTF: ImageTextFiledView!
    var passwordTF: ImageTextFiledView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navLab.text = "登录"
        
        self.addSubView()
        
        let defaultStand = UserDefaults.standard
        let name = defaultStand.string(forKey: UserDefaultKeys.AccountInfo().userName)
        let password = defaultStand.string(forKey: UserDefaultKeys.AccountInfo().password)
        
        //可选类型 不能强制解包，建议重新赋值个变量后，使用新建的变量
        if let tempName = name,let tempPass = password{
//            if !tempName.isEmpty && !tempPass.isEmpty
//            {
//                self.nameTF.text = tempName
//                self.passwordTF.text = tempPass
//            }
            
            //也可以使用Guard 语句
            guard tempName.isEmpty || tempPass.isEmpty else {
                self.nameTF.text = tempName
                self.passwordTF.text = tempPass
                
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func addSubView()
    {
        bgView.frame = CGRect.init(x: 10, y: 160, width: kScreenWidth - 10 * 2, height: 260)
        bgView.backgroundColor = UIColor.white
        self.view .addSubview(bgView)
        
        nameTF = ImageTextFiledView.init(frame: CGRect.init(x: 10, y: 10, width: bgView.width - 10 * 2, height: 40), image: "icon_5", highImage: "icon_6", line: true)
        nameTF.placeholder = "请输入用户名";
        nameTF.textAlignment = NSTextAlignment.left
        nameTF.font = UIFont.systemFont(ofSize: 14)
//        nameTF.textColor = UIColor.red
        bgView .addSubview(nameTF)

        passwordTF = ImageTextFiledView.init(frame: CGRect.init(x: nameTF.x, y: nameTF.maxY + 10, width: nameTF.width, height: nameTF.height),image: "icon_7",highImage: "icon_8", line: false)
        passwordTF.placeholder = "请输入密码"
        passwordTF.textAlignment = NSTextAlignment.left
        passwordTF.font = UIFont.boldSystemFont(ofSize: 14)
//        passwordTF.textColor = UIColor.cyan
        passwordTF.isSecureTextEntry = true
        passwordTF.clearButtonMode = UITextFieldViewMode.whileEditing
        bgView .addSubview(passwordTF)
        
        let loginBtn = UIButton.init(frame: CGRect.init(x: 0, y: passwordTF.maxY, width: bgView.width, height: passwordTF.height))
        loginBtn.backgroundColor = kColorBlue1
        loginBtn.setTitle("登录", for: UIControlState.normal)
        loginBtn.showsTouchWhenHighlighted = true
        loginBtn.addTarget(self, action: #selector(loginBtnPress(button:)), for: UIControlEvents.touchUpInside)
        
        bgView .addSubview(loginBtn)
        
        //忘记密码 注册
        let forgetBtn = UIButton.init(type: UIButtonType.custom)
        forgetBtn.frame = CGRect.init(x: bgView.width - 80 - 60, y: loginBtn.maxY, width: 80, height: 30)
        forgetBtn.setTitle("忘记密码？", for: UIControlState.normal)
        forgetBtn.setTitleColor(kColorBlue1, for: UIControlState.normal)
        forgetBtn .addTarget(self, action: #selector(forgetBtnPress), for: UIControlEvents.touchUpInside)
        forgetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        bgView .addSubview(forgetBtn)
        
        let registerBtn = UIButton.init(frame: CGRect.init(x: forgetBtn.maxX, y: forgetBtn.y, width: 60, height: forgetBtn.height))
        registerBtn.setTitle("| 新注册", for: UIControlState.normal)
        registerBtn.setTitleColor(kColorBlue1, for: UIControlState.normal)
        registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerBtn .addTarget(self, action: #selector(registerBtnPress), for: UIControlEvents.touchUpInside)
        registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        bgView .addSubview(registerBtn)
    }
    
    //MARK: Button  Press
    @objc func loginBtnPress(button:UIButton) {
        print("点击登录---=")
//        [NSString stringWithFormat:@"%@/user/login", API_BASE_URL]
//        vc.requestUrl = API_BASE_URL + "/learn/getLearnPlan_new"
//        vc.requestParams = ["userId" : userId!,"userSessionId" : sessionId!,"pageNum" : "1","pageSize" : "5","planType" : "2"]
        
        let name = self.nameTF.text
        let passddd = self.passwordTF.text
        if (name?.isEmpty)! || (passddd?.isEmpty)! {
            return
        }
        
        let reuquestUrl = API_BASE_URL + "/user/login"
        let phone = self.nameTF.text
        let password = self.passwordTF.text?.md5()
        
        let requestDic = ["phoneNumber":phone,"passWord":password]
        
        CETCSwiftNetWork.init().post(url: reuquestUrl, params: requestDic, success: { response in
            
            //保存信息
            let userDefault = UserDefaults.standard
            userDefault.set(name, forKey: UserDefaultKeys.AccountInfo().userName)
            userDefault.set(passddd, forKey: UserDefaultKeys.AccountInfo().password)
            
            let userModel = UserModel.shareUser
            userModel.userId = JSON(response)["userId"].string
            userModel.userSessionKey = JSON(response)["userSessionId"].string
            
            let vc = CETCSwiftTableviewVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
//            print("login response 回调 =====\n\(response)")
            
        }) { error in
            print("login response error =====\n\(error)")
        }

        //加密
//        NSString *encryptPassWord = [self.passwordField.text md5String];
//
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:self.usernameField.text forKey:@"phoneNumber"];
//        [dic setObject:encryptPassWord forKey:@"passWord"];
//
//        NSString *rigisterId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_REGIST_ID];
//        NSString *rigistedPushId = [rigisterId stringByAppendingString:@"|1"];
//        if ([rigisterId length] > 0)
//        {
//            [dic setObject:rigistedPushId forKey:@"pushToken"];
//        }
//
//        [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeBlack];
//        swiftnet
    }
    
    @objc func forgetBtnPress() -> Void {
        
        let vc = ForgetViewController()
        let vc2 = TestViewController()
        self .present(vc, animated: true, completion: nil)
    }
    
    @objc func registerBtnPress() -> Void {
        
        let registerVC = RegisterViewController()
        
        let navCtrl = UINavigationController.init(rootViewController: registerVC)
        
        self.present(navCtrl, animated: true, completion: nil)
    }
    
    func sendCode(button:UIButton)  {
        print("发送验证码")
    }
}

