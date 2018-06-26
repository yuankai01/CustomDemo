//
//  ForgetViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/9/29.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class ForgetViewController: LoginBgImageVC {

    var forgetView: RegisterForgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navLab.text = "忘记密码"
        
        let dismissBtn = UIButton.init(frame: CGRect.init(x: 0, y: 20, width: 60, height: 44))
//        dismissBtn.backgroundColor = kColorBlue1
//        dismissBtn.setTitle("返回", for: UIControlState.normal)
        dismissBtn.setImage(UIImage.init(named: "btn_back2"), for: UIControlState.normal)
        dismissBtn.showsTouchWhenHighlighted = true
        dismissBtn.addTarget(self, action: #selector(dismissVC), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(dismissBtn)
        
        //内容视图
        forgetView = RegisterForgetView.init(frame: CGRect.init(x: 10, y: 100, width: kScreenWidth - 10 * 2, height: 200), viewType: ViewType.ForgetView)
        self.view .addSubview(forgetView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissVC() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        forgetView .registerAllTextField()
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
