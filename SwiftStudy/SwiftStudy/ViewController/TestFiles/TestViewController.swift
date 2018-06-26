//
//  TestViewController.swift
//  SwiftLogin
//
//  Created by gao on 16/10/14.
//  Copyright © 2016年 Gao. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var testLab: UILabel!
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var testTextField: UITextField!
    
    var testTableView: UITableView!
    
    
    var nameLab: UILabel!
    
    var testName:UILabel!
    
    var password = UILabel.init()
    
    var aView: TestAView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testLab.frame = CGRect.init(x: 10, y: 100, width: 100, height: 40)
        testLab.backgroundColor = UIColor.red
        
        nameLab = UILabel.init(frame: CGRect.init(x: 200, y: 200, width: 100, height: 50))
        nameLab.backgroundColor = UIColor.cyan
        self.view .addSubview(nameLab)
        
        aView = TestAView.init(frame: CGRect.zero)
        aView.publicMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
