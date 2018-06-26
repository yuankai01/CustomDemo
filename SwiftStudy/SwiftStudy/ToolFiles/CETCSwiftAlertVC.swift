//
//  CETCSwiftAlertVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/30.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit

class CETCSwiftAlertVC: CETCSwiftBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您确定要离开hangge.com吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        UIAlertController.showAlert(message: "dfada")
        UIAlertController.showAlert(message: "sdfa", in: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentStyleAction() -> Void {
        
        let alertController = UIAlertController(title: "保存或删除数据", message: "删除数据将不可恢复",
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: nil)
        let archiveAction = UIAlertAction(title: "保存", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func dismissAfterDelay(time : Float) -> Void {
        
        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }

}
