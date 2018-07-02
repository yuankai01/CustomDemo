//
//  FMDBViewController.m
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDB.h"

#define kFMDBName       @"fmdb_db.sqlite"
#define kFMDBTabName    @"t_student"

static NSString *keyId = @"keyId";
static NSString *keyName = @"keyName";
static NSString *keyAge = @"keyAge";
static NSString *keySex = @"keySex";

@interface FMDBViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSString *_docPath;
    NSString *fmdbPath;
    FMDatabase *fmdb;
    int mark_student;
    
    NSArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    
    mark_student = 1;
    [self openFMDB];
    
    [self selectData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openFMDB
{
    //1.获取数据库文件的路径
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"fmdbPath ==== %@",_docPath);
//    mark_student = 1;
    //设置数据库名称
    fmdbPath = [_docPath stringByAppendingPathComponent:@"fmdb_db.sqlite"];
    //2.获取数据库
    fmdb = [FMDatabase databaseWithPath:fmdbPath];
    if ([fmdb open]) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败");
    }
}

#pragma mark - action
/* 创建表时会自动生成sqlite_sequence表
 sqlite_sequence表也是SQLite的系统表。初始化时是没有数据的。当往自建的表填充数据后，sqlite_sequence表会生成对应的数据：表名：name;操作记录次数：seq
 该表用来保存其他表的RowID的最大值。数据库被创建时，sqlite_sequence表会被自动创建。该表包括两列。第一列为name，用来存储表的名称。第二列为seq，用来保存表对应的RowID的最大值（操作记录的次数）。该值最大值为9223372036854775807。当对应的表增加记录，该表会自动更新。当表删除，该表对应的记录也会自动删除。如果该值超过最大值，会引起SQL_FULL错误。所以，一旦发现该错误，用户不仅要检查SQLite文件所在的磁盘空间是否不足，还需要检查是否有表的ROWID达到最大值。
 */
//创建表：对应的表字段：id、name、age、sex
- (IBAction)creatTable:(id)sender {
    //3.创建表
    BOOL result = [fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS tt_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

- (IBAction)insert:(id)sender {
    //插入数据
    NSString *name = [NSString stringWithFormat:@"王子涵%@",@(arc4random() % 100)];
    int age = arc4random() % 100;
    NSString *sex = arc4random() % 2 == 0 ? @"女" : @"男";
    mark_student ++;
    BOOL result = NO;
    
    switch (mark_student % 3) {
        case 0:
            //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，否则崩溃：Thread 1: EXC_BAD_ACCESS ，；代表语句结束）
            result = [fmdb executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
            break;
        case 1:
            //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
            result = [fmdb executeUpdateWithFormat:@"insert into tt_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
            break;
        case 2:
            //3.参数是数组的使用方式
            result = [fmdb executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
            break;
        default:
            break;
    }
    
    if (result) {
        NSLog(@"插入成功");
        [self selectData:nil];
    } else {
        NSLog(@"插入失败");
    }
}

- (IBAction)delete:(id)sender {
    int age = 30;
    BOOL result = NO;
    switch (arc4random() % 2) {
        case 0:
            //1.executeUpdate: 不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象，否则崩溃：Thread 1: EXC_BAD_ACCESS ）
            result = [fmdb executeUpdate:@"delete from t_student where age <= ?",@(age - 14)];
            NSLog(@"--------000000000000--------");
            break;
        case 1:
            //2.executeUpdateWithFormat：不确定的参数用%@，%d等来占位
            result = [fmdb executeUpdateWithFormat:@"delete from t_student where age > %d",age];
            NSLog(@"--------111111111111--------");
            break;
        case 4:
            //3.withArgumentsInArray:[db executeUpdate:@"delete from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
            result = [fmdb executeUpdate:@"delete from 't_student' where ID = ?" withArgumentsInArray:@[@113]];;
            NSLog(@"--------22222222222222--------");
            break;
        default:
            break;
    }
    
    if (result) {
        NSLog(@"删除成功");
        [self selectData:nil];
    } else {
        NSLog(@"删除失败");
    }
}

- (IBAction)select:(id)sender {
    [self selectData:sender];
}

- (void)selectData:(UIButton *)sender
{
    FMResultSet * resultSet = nil;
    if (sender) {   //查询整个表
        resultSet = [fmdb executeQuery:@"select * from t_student where age < ?", @(55)];
    }else   //根据条件查询
    {
        resultSet = [fmdb executeQuery:@"select * from t_student"];
    }
    
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    dataArray = nil;
    //遍历结果集合
    while ([resultSet next]) {
        int idNum = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSString *sex = [resultSet objectForColumn:@"sex"];
        
        NSDictionary *dic = @{keyId: @(idNum),keyName: name,keyAge : @(age),keySex:sex};
        [muArray addObject:dic];
        NSLog(@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex);
    }
    
    dataArray = muArray;
    
    [self.tableView reloadData];
}

- (IBAction)modify:(id)sender {
    //修改学生的名字
    NSString *newName = @"李浩宇";
//    NSString *oldName = @"王子涵2";
    BOOL result = [fmdb executeUpdate:@"update t_student set name = ? where age > ?",newName,@(60)];
    if (result) {
        NSLog(@"修改成功");
        [self selectData:nil];
    } else {
        NSLog(@"修改失败");
    }
}

//删除表
- (IBAction)deleteTable:(id)sender {
    //如果表格存在 则销毁
    BOOL result = [fmdb executeUpdate:@"drop table if exists tt_student"];
    if (result) {
        NSLog(@"删除表成功");
        [self selectData:nil];
    } else {
        NSLog(@"删除表失败");
    }
}

#pragma mark - FMDatabaseQueue 多线程安全
/*  FMDB 中的多线程处理
 链接：https://www.jianshu.com/p/cb60951cdc31
 */
- (IBAction)mutiThreadGCD:(id)sender {
    
    /* 下面代码单独是可以插入成功的。
     NSInteger identifier = 1;
     NSString *name = @"Tom";
     NSInteger age = 28;
     NSDictionary *arguments = @{@"sex": @(identifier),
     @"name": name,
     @"age": @(age)};
     if ([self insertIntoTablePerson:fmdb arguments:arguments]) {
     NSLog(@"Tom 插入成功 - %@", [NSThread currentThread]);
     }
     
     return;
     */
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __weak typeof(fmdb) weakFMDB = fmdb;
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSInteger identifier = 0;
        NSString *name = @"Demon";
        NSInteger age = 20;
        NSDictionary *arguments = @{@"sex": @(identifier),
                                    @"name": name,
                                    @"age": @(age)};
        if ([self insertIntoTablePerson:weakFMDB arguments:arguments]) {
            NSLog(@"Demon 插入成功 - %@", [NSThread currentThread]);
        }
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_async(group, queue, ^{
        NSInteger identifier = 1;
        NSString *name = @"Jemmy";
        NSInteger age = 25;
        NSDictionary *arguments = @{@"sex": @(identifier),
                                    @"name": name,
                                    @"age": @(age)};
        if ([self insertIntoTablePerson:weakFMDB arguments:arguments]) {
            NSLog(@"Jemmy 插入成功 - %@", [NSThread currentThread]);
        }
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_async(group, queue, ^{
        NSInteger identifier = 0;
        NSString *name = @"Michael";
        NSInteger age = 42;
        NSDictionary *arguments = @{@"sex": @(identifier),
                                    @"name": name,
                                    @"age": @(age)};
        if ([self insertIntoTablePerson:weakFMDB arguments:arguments]) {
            NSLog(@"Michael 插入成功 - %@", [NSThread currentThread]);
        }
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
        // 查询
//        FMResultSet *s = [weakFMDB executeQuery:@"select * from t_student"];
//        while ([s next]) {
//            NSString *name = [s stringForColumnIndex:0];
//            int age = [s intForColumnIndex:1];
//            int identifier = [s intForColumnIndex:2];
//            NSLog(@"name=%@, age=%d,sex=%d", name, age, identifier);
//        }
//
//        [weakFMDB close];
    });
    
    /* 崩溃：打印信息
     2018-07-02 10:58:04.870146+0800 SQL&FMDB&CoreData[2189:332773] The FMDatabase <FMDatabase: 0x60c0000a09c0> is currently in use.
     2018-07-02 10:58:04.870146+0800 SQL&FMDB&CoreData[2189:332772] The FMDatabase <FMDatabase: 0x60c0000a09c0> is currently in use.
     2018-07-02 10:58:04.870336+0800 SQL&FMDB&CoreData[2189:332772] error = not an error
     2018-07-02 10:58:04.870337+0800 SQL&FMDB&CoreData[2189:332773] error = not an error
     2018-07-02 10:58:04.870617+0800 SQL&FMDB&CoreData[2189:332744] 完成 - <NSThread: 0x6080000679c0>{number = 1, name = main}
     2018-07-02 10:58:04.884764+0800 SQL&FMDB&CoreData[2189:332770] Demon 插入成功 - <NSThread: 0x600000076b00>{number = 3, name = (null)}
     
     可以看到，三条插入语句分别开启了三个线程332772、332773、332770，只有Demon 线程332770 插入成功了，另外两条都提示了error = not an error。
     */
}

/* <#注释#>
 FMDatabaseQueue解决线程安全的操作方法：
 FMDatabaseQueue使用下面这个函数对数据库进行操作，通过描述可知，这样等于是把数据库的操作放到一个串行队列中，从而保证不会在同一时间对数据库做改动。
 看下FMDatabaseQueue的源码，发现了一个串行的queue，而且这个queue是同步调用
 */
//利用FMDatabaseQueue的块方法 - (void)inDatabase:(void (^)(FMDatabase *db))block;
- (IBAction)fmdbQueue:(id)sender {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __weak typeof(fmdbPath) weakPath = fmdbPath;
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:weakPath];
        [queue inDatabase:^(FMDatabase *db) {
            if ([db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?, ?, ?)", @"Demon-Queue", @20, @0]) {
                NSLog(@"Demon 插入成功 - %@", [NSThread currentThread]);
            }
            
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:weakPath];
        [queue inDatabase:^(FMDatabase *db) {
            if ([db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?, ?, ?)", @"Jemmy-Queue", @25, @1]) {
                NSLog(@"Jemmy 插入成功 - %@", [NSThread currentThread]);
            }
            
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:weakPath];
        [queue inDatabase:^(FMDatabase *db) {
            if ([db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?, ?, ?)", @"Michael-Queue", @42, @2]) {
                NSLog(@"Michael 插入成功 - %@", [NSThread currentThread]);
            }
            
            dispatch_group_leave(group);
        }];
    });
    
    __weak typeof(fmdb) weakFMDB = fmdb;

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
        // 查询
        FMResultSet *s = [weakFMDB executeQuery:@"select * from t_student"];
        while ([s next]) {
            NSString *name = [s stringForColumnIndex:1];
            int age = [s intForColumnIndex:2];
            int identifier = [s intForColumnIndex:3];
            NSLog(@"name=%@, age=%d,sex=%d", name, age, identifier);
        }
        
//        [weakFMDB close];     //测试用 不用关闭
    });
    
    /* 打印信息
     2018-07-02 12:33:45.990150+0800 SQL&FMDB&CoreData[3029:538096] Jemmy 插入成功 - <NSThread: 0x600000465880>{number = 9, name = (null)}
     2018-07-02 12:33:46.066189+0800 SQL&FMDB&CoreData[3029:537396] Demon 插入成功 - <NSThread: 0x60c00026df80>{number = 10, name = (null)}
     2018-07-02 12:33:46.076687+0800 SQL&FMDB&CoreData[3029:536864] Michael 插入成功 - <NSThread: 0x60800007ef40>{number = 11, name = (null)}
     2018-07-02 12:33:46.077010+0800 SQL&FMDB&CoreData[3029:529710] 完成 - <NSThread: 0x60000007ddc0>{number = 1, name = main}
     
     通过上面的运行结果可以看出三条insert 语句全部执行成功，并且分别在三个线程538096、537396、536864中，相互之间并没有影响，可见FMDatabaseQueue 可以有效的保证其中执行sql 的线程安全。
     */
}

- (BOOL)insertIntoTablePerson:(FMDatabase *)db arguments:(NSDictionary *)arguments {
    BOOL success = [db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (:name, :age, :sex)"
             withParameterDictionary:arguments];
    if (!success) {
        NSLog(@"error = %@", [db lastErrorMessage]);
    }
    
    return success;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dic = dataArray[indexPath.row];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - 姓名：%@,年龄： %@,性别：%@,id号== %@",indexPath.row + 1,dic[keyName],dic[keyAge],dic[keySex],dic[keyId]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
