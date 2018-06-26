//
//  CETCLearnPlanCell.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/14.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit
import AlamofireImage

class CETCLearnPlanCell: UITableViewCell {

    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func contentModel(model:LearnPlanModel) -> Void {
        
        self.headImgView.backgroundColor = UIColor.cyan
        self.headImgView.image = UIImage.init(named: "chat_placeholder_image")
        self.titleLab.text = "学习计划列表标题adfad是的"
        self.contentLab.text = "学习计划礼拜内容"
        self.dateLab.text = "2011-10-20"
        
//        self.headImgView.af_setImage(withURL: NSURL.init(string: model.image_url!)! as URL)
        self.headImgView.setImageUrl(model.image_url, "chat_placeholder_image")
        self.titleLab.text = model.title
        self.contentLab.text = model.company_name
        self.dateLab.text = model.plan_end_date
    }
}
