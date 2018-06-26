//
//  CETCSwiftTableviewVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/10/19.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit
import SwiftyJSON
import ESPullToRefresh

let testCell : String = "testCell"

class CETCSwiftTableviewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let dataArray = ["学习计划","四学","Collection","上传图片"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift学习"
        self.addRightNavBar()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)

        print("sder ==== \(API_BASE_URL)")
//        testJson()
    }

    @objc func logout() -> Void {

        let url = API_BASE_URL + "/user/loginOut"
        let reqDic : [String : Any] = ["userId" : UserModel.sharedUserModel().userId,"userSessionId" : UserModel.sharedUserModel().userSessionKey]
        
        CETCSwiftNetWork.init().post(url: url, params: reqDic, success: { response in
            
//            self.navigationController ?.popViewController(animated: true)
            
            //切换根视图或者直接pop回去
            let testVC = LoginViewController()
            let navVC = UINavigationController.init(rootViewController: testVC)
            
            UIApplication.shared.keyWindow?.rootViewController = navVC
            
            //因为没有用到Xib所以下面代码无效
            /*
             let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let viewController = mainStoryboard.instantiateViewController(withIdentifier: "FirstView") as! UINavigationController
             UIApplication.shared.keyWindow?.rootViewController = viewController
             
             作者：YifBo
             链接：https://www.jianshu.com/p/2e4b3ac918d8
             */

        }) { error in
            
        }
    }
    
    func addRightNavBar() -> Void {
        let rightBtn : UIButton = UIButton.init(type: UIButtonType.custom)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 40)
        rightBtn .addTarget(self, action: #selector(logout), for: UIControlEvents.touchUpInside)
        rightBtn.backgroundColor = UIColor.lightGray
        rightBtn.setTitle("退出", for: UIControlState.normal)
        
        let rightBar = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:json test
    func testJson() -> Void {
        
        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            //.........
            
            //提示try错误时，利用try定义的可选链进行定义；或者用do catch语句进行
            let json = try? JSON(data: jsonData)
            if let number = json![0]["phones"][0]["number"].string {
                // 找到电话号码
                print("第一个联系人的第一个电话号码：",number)
            }
            
            //do catch语句
//            do{
//                let json = try JSON(data:jsonData)
//            }catch{
//
//            }
        }
    }
    
    //MARK:tableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: testCell, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row % dataArray.count]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tag = indexPath.row % 4
        let userId  = UserModel.shareUser.userId
        let sessionId = UserModel.shareUser.userSessionKey
        
        switch tag {
        case 0:
            let vc = CETCLearnPlanVC()
            vc.navTitle = "学习计划"
            vc.requestUrl = API_BASE_URL + "/learn/getLearnPlan_new"
            vc.requestParams = ["userId" : userId!,"userSessionId" : sessionId!,"pageNum" : "1","pageSize" : "5","planType" : "2"]
                
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CETCSwiftFourLearVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CETCSwiftCollectionViewVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = CETCUploadImagesVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    //MARK:懒加载
    lazy var tableView: UITableView! = {
        var tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.cyan
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: testCell)
        
        return tableView
    }()
}
