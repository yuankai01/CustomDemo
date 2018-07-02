//
//  CoreDataViewCell.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *workNumLab;

@end
