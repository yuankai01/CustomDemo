//
//  ImageBgViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/9/26.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

var ddasf = UIImage(named:"123")
var fafaf = UIImage(named:"adfa")

class LoginBgImageVC: UIViewController {

    var navTitle = NSString.init()
    var navLab = UILabel.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
        
        let bgImgView = UIImageView.init(image: UIImage.init(named: "bg_login"))
        bgImgView.frame = self.view.bounds
        self.view.addSubview(bgImgView)
        
        navLab.frame = CGRect.init(x: 0, y: 25, width: kScreenWidth, height: 44)
        navLab.textAlignment = NSTextAlignment.center
        navLab.textColor = UIColor.black
        navLab.font = UIFont.systemFont(ofSize: 18)
        self.view .addSubview(navLab)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
