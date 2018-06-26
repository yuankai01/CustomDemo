//
//  CETCSwiftFourLearVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/12/1.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit

class CETCSwiftFourLearVC: CETCSwiftBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navTitle = "引导学"
        
        getFourLearnRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFourLearnRequest() -> Void {
        
        let userId  = UserModel.shareUser.userId
        let sessionId = UserModel.shareUser.userSessionKey
        
        let requestUrl = API_BASE_URL + "/exchange/dataListByModuleId"
        let requestParams = ["userId" : userId!,"userSessionId" : sessionId!,"pageNum" : "1","pageSize" : "4","moduleId" : "1","typeIdAndNames" : ""]
        
        CETCSwiftNetWork.init().post(url: requestUrl, params: requestParams, success: { response in
            
            print("response 回调 =====\(response)")
            
        }) {error in
            
        }
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
