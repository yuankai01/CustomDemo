//
//  CETCLearnPlanVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/13.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ESPullToRefresh
//import <#module#>

class CETCLearnPlanVC: CETCSwiftBaseVC,UITableViewDataSource,UITableViewDelegate {
    public var page = 1
    
    //声明变量 必须初始化赋值：空值或真实值
    var requestUrl: String = ""
    var requestParams : [String : Any] = [:]
    var dataArray = [] as Array
    
    //MARK:生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
//        self.navTitle = "学习计划"
        
        self.view.addSubview(self.planTableView)
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//        var reversedNames = names.sorted(by: backward)
        let rever = names.sorted(by: backward)
        print("排序完：\(rever)")
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        planTableView.es.addPullToRefresh(animator: header) {
            self.refresh()
            self.planTableView.es.stopPullToRefresh()
        }
        planTableView.es.startPullToRefresh()

        planTableView.es.addInfiniteScrolling(animator: footer) {
            self.loadMore()
        }
        self.planTableView.es.base.header?.backgroundColor = UIColor.red
        self.planTableView.es.base.footer?.backgroundColor = UIColor.cyan
        
        self.planTableView.refreshIdentifier = String.init(describing: "defaulttype")
//        self.planTableView.expiredTimeInterval = 20.0
    }
    
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.page = 1
            self.getLearnPlanList()
        }
    }
    
    private func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.page += 1
            self.getLearnPlanList()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //屏幕亮度
//        UIScreen.main.brightness = 0.1;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //屏幕亮度
//        UIScreen.main.brightness = 1;
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    //MARK: 网络请求
    func getLearnPlanList() -> Void {
        SwiftProgressHUD.showWait()
        
        let userId  = UserModel.shareUser.userId
        let sessionId = UserModel.shareUser.userSessionKey
        let pageSize = 4
        
        requestParams = ["userId" : userId!,"userSessionId" : sessionId!,"pageNum" : page,"pageSize" : pageSize,"planType" : "2"]
        
        //requestUrl 从前面传过来的
        CETCSwiftNetWork.init().post(url: requestUrl, params: requestParams, success: { response in
            
            if self.page == 1 {
                self.dataArray.removeAll()
            }
            
            let tempArray = JSON(response)["list"].arrayObject!

            if tempArray.isEmpty{
                self.page -= 1
            }else
            {
                for data in tempArray {
                    let model = LearnPlanModel.init(jsonData: JSON(data))
                    self.dataArray.append(model)
                }
            }
            
            self.planTableView.reloadData()
            
            SwiftProgressHUD.hideAllHUD()
            print("response 回调 =====\n\(tempArray)")
            
            self.planTableView.es.stopPullToRefresh()
            self.planTableView.es.stopLoadingMore()
            
            //数据加载完毕，不在有新数据，隐藏上拉加载
            if tempArray.count < pageSize {
                self.planTableView.es.noticeNoMoreData()
                self.planTableView.es.base.footer?.isHidden = true
            }
            
        }) {error in
            SwiftProgressHUD.hideAllHUD()
        }
    }
    
    //MARK:tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: CETCLearnPlanCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CETCLearnPlanCell
        
//        cell.contentView.backgroundColor = UIColor.randomColor
        
        let learnModel = self.dataArray[indexPath.row] as? LearnPlanModel
        
        if let learnModel = learnModel {
            cell.contentModel(model: learnModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btnTag = indexPath.item + 1
        
        if btnTag == 1 { // wait
            /// 设置蒙版背景颜色, 默认是clear
//            SwiftP,rogressHUD.hudBackgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            /// 开始loading...
            SwiftProgressHUD.showWait()
            
        }else if btnTag == 2 { // success
            
            SwiftProgressHUD.showSuccess("加载成功")
            
        }else if btnTag == 3 { // fail
            
            SwiftProgressHUD.showFail("加载失败")

        }else if btnTag == 4 { // info
            
            SwiftProgressHUD.showInfo("请稍后")

        }else if btnTag == 5 { // showOnlyText
            
            SwiftProgressHUD.showOnlyText("请输入合法的手机号")
        }else if btnTag == 6 { // showOnStatusBar
//            SwiftProgressHUD.showOnStatusBar("你有一条新消息", autoClear: true, autoClearTime: 1, textColor: UIColor.orange, backgroundColor: UIColor.lightGray)
        }
        
//        SwiftProgressHUD.hideAfterDlay(time: 1)
    }

    //MARK:懒加载
    lazy var planTableView: UITableView = {
        
        let tempTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width - 0 * 2, height: self.view.bounds.height - 0 * 2 - 64 - 0), style: UITableViewStyle.grouped)
        tempTableView.dataSource = self
        tempTableView.delegate = self
//        tempTableView.register(CETCLearnPlanCell.self, forCellReuseIdentifier: "cell")
        tempTableView.register(UINib.init(nibName: "CETCLearnPlanCell", bundle: nil), forCellReuseIdentifier: "cell")
        tempTableView.estimatedRowHeight = 100;
        tempTableView.estimatedSectionHeaderHeight = 0;
        tempTableView.estimatedSectionFooterHeight = 0;
        
//        tempTableView.translatesAutoresizingMaskIntoConstraints = false
//        if #available(iOS 11.0, *) {
//            tempTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
//        }
        
//        tempTableView.backgroundColor = UIColor.red
        
        return tempTableView
    }()

}
