//
//  CETCSwiftCollectionViewVC.swift
//  CETCPartyBuilding
//
//  Created by gao on 2017/11/23.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

import UIKit

class CETCSwiftCollectionViewVC: CETCSwiftBaseVC,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let collectionCell = "collectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(myCollectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath)
        
        let label = UILabel.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 80, height: 80)))
        label.backgroundColor = UIColor.init(red: CGFloat(arc4random() % 255 / 255), green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1)
        
        label.textAlignment = NSTextAlignment.center
        label.text = "第\(indexPath.item)行"
        
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    //MARK:懒加载
    lazy var myCollectionView : UICollectionView! = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize.init(width: 80, height: 80)
        
        let tempCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        tempCollectionView.backgroundView = nil
        tempCollectionView.backgroundColor = UIColor.clear
        tempCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.collectionCell)
        tempCollectionView.dataSource = self
        tempCollectionView.delegate = self
        
        return tempCollectionView
    }()
}
