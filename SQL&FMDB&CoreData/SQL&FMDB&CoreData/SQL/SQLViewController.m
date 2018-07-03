//
//  SQLViewController.m
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

#import "SQLViewController.h"
#import "SQLService.h"

@interface SQLViewController ()
{
    SQLService *sqlService;
}

@end

@implementation SQLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    sqlService = [[SQLService alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建数据库sqlite文件
- (IBAction)SaveButtonPress:(id)sender {
    SQLService *sql = [[SQLService alloc] init];
    [sql openSQL];
}

#pragma mark - 添加数据
- (IBAction)addButtonPress:(id)sender {
    PassValue *value = [[PassValue alloc] init];
//    value.name = self.NameTextField.text;
//    value.sex = self.SexTextField.text;
//    value.age = [self.ageTextField.text integerValue];
    
    value.name = [NSString stringWithFormat:@"name%d",arc4random() % 100 + 1];
    value.sex = [NSString stringWithFormat:@"%d",arc4random() % 2];
    value.age = arc4random() % 100 + 1;
    
    BOOL success = [sqlService insertData:value];
    if (success) {
//        self.NameTextField.text = @"";
//        self.SexTextField.text = @"";
//        self.ageTextField.text = @"";
//        [self.NameTextField becomeFirstResponder];
    }
}

- (IBAction)deleteButtonPress:(id)sender {
    PassValue *value = [[PassValue alloc] init];
//    value.name = self.NameTextField.text;
//    value.sex = self.SexTextField.text;
//    value.age = [self.ageTextField.text integerValue];
    value.age = 10;
    //删除年龄大于60的数据
    [sqlService delteData:value.age];
}

- (IBAction)ModifyButtonPress:(id)sender {
    PassValue *value = [[PassValue alloc] init];

    value.name = [NSString stringWithFormat:@"modify-name%d",arc4random() % 100 + 1];
    value.sex = [NSString stringWithFormat:@"%d",arc4random() % 2];
    value.age = arc4random() % 100 + 1;
    
    [sqlService modifyData:value];
}

- (IBAction)selectButtonPress:(id)sender {
    SQLService *sql = [[SQLService alloc] init];
    [sql searchDatabase:2];
}

@end
