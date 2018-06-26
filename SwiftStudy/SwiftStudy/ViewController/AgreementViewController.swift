//
//  AgreementViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/10/17.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.title = "服务协议"
        // Do any additional setup after loading the view.
        
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: "btn_back2"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        leftItem.tintColor = kColorBlue1
        self.navigationItem.leftBarButtonItem = leftItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back()
    {
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
