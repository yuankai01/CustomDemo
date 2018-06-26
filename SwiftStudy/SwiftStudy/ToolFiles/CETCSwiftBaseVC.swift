//
//  CETCSwiftBaseVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/13.
//  Copyright © 2017 Aaron Yu. All rights reserved.
//

import UIKit

class CETCSwiftBaseVC: UIViewController {

    var navTitle: String?{
        didSet{     //赋值时调用
            self.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
