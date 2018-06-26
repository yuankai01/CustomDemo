//
//  LearnPlanModel.swift
//  CETCPartyBuilding
//
//  Created by gao on 2018/2/6.
//  Copyright © 2018年 Aaron Yu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LearnPlanModel {
    var image_url: String?
    var title: String?
    var company_name: String?
    var plan_end_date: String?
    var room_num: String?
    var area_address: String?
    
    init(jsonData: JSON) {
        image_url = jsonData["image_url"].stringValue
        title    = jsonData["title"].stringValue
        company_name = jsonData["company_name"].stringValue
        plan_end_date  = jsonData["plan_end_date"].stringValue
        room_num      = jsonData["room_num"].stringValue
        area_address     = jsonData["build_num"].stringValue
    }
}
