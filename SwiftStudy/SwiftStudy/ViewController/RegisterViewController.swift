//
//  RegisterViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/9/29.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class RegisterViewController: LoginBgImageVC, RegisterForgetDelegate {

    var registerView: RegisterForgetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        self.title = "注册"

        //内容视图
        registerView = RegisterForgetView.init(frame: CGRect.init(x: 10, y: 120, width: kScreenWidth - 10 * 2, height: 260), viewType: ViewType.RegisterView)
        registerView.delegate = self
        self.view .addSubview(registerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        registerView.registerAllTextField()
    }
    
    func dismissVC() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - RegisterForgetDelegate
    func sureParames(paramesDic: NSDictionary) {
        
    }
    
    func agreement() {
        let vc = AgreementViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func backLogin() {
//        self.dismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
