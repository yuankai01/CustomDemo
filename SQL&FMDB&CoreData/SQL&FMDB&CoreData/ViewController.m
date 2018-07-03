//
//  ViewController.m
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

#import "ViewController.h"

#import "SQLViewController.h"
#import "CoreDataViewController.h"
#import "FMDBViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArray;
}

@property (strong, nonatomic) UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dataArray = [[NSMutableArray alloc] init];
    [dataArray addObject:@"SQL"];
    [dataArray addObject:@"CoreData"];
    [dataArray addObject:@"FMDB"];
    
    [self.view addSubview:self.myTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *title = dataArray[indexPath.row % dataArray.count];
    cell.textLabel.text = title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = indexPath.row % dataArray.count;
    switch (index) {
        case 0:
        {
            SQLViewController *vc = [[SQLViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            CoreDataViewController *vc = [[CoreDataViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            FMDBViewController *vc = [[FMDBViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 懒加载 *******
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _myTableView;
}

@end
