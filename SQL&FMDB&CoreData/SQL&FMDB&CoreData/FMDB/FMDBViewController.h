//
//  FMDBViewController.h
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

/* iOS FMDB库详解 https://www.jianshu.com/p/7ac1c6eb63ed
 1.是对libsqlite3库的封装，使用起来简洁、高效，没有原来的一大堆晦涩难懂、影响开发效率的C语句，更加面向对象
 2.非常的轻量化、灵活
 3.对于多线程的并发操作进行了处理，是线程安全的（重要特性之一）
 4.因为它是OC语言封装的，只能在ios开发的时候使用，所以在实现跨平台操作的时候存在局限性
 
 FMDB重要（常用）类
 FMDatabase：一个FMDatabase对象就代表一个单独的SQLite数据库（注意并不是表），用来执行SQL语句
 FMResultSet：使用FMDatabase执行查询后的结果集
 FMDatabaseQueue：用于在多线程中执行多个查询或更新,它是线程安全的
 FMDBMigrationManager:对数据库进行版本升级：如添加新的字段等
 */

/* FMDB的事务  https://www.jianshu.com/p/7958d31c2a97
 5.FMDB的事务
 (1) 事务定义：
 事务(Transaction)是并发操作的基本单位，是指单个逻辑工作单位执行的一系列操作序列，这些操作要不都成功，要不就不成功，事务是数据库维护数据一致性的单位，在每个事务结束时，都能保证数据一致性与准确性，通常事务跟程序是两个不同的概念，一个程序中包含多个事务，事务主要解决并发条件下操作数据库，保证数据
 (2) 事务特征：
 原子性（Atomic）：事务中包含的一系列操作被看作一个逻辑单元，这个逻辑单元要不全部成功，要不全部失败
 一致性（Consistency）：事务中包含的一系列操作，只有合法的数据被写入数据库，一些列操作失败之后，事务会滚到最初创建事务的状态
 隔离性（Isolation）：对数据进行修改的多个事务之间是隔离的，每个事务是独立的，不应该以任何方式来影响其他事务
 持久性（Durability）事务完成之后，事务处理的结果必须得到固化，它对于系统的影响是永久的，该修改即使出现系统固执也将一直保留，真实的修改了数据库
 (3) 事务语句：
 transaction:事务 开启一个事务执行多个任务，效率高
 1.fmdb 封装transaction 方法，操作简单
 - (BOOL)beginTransaction;
 - (BOOL)beginDeferredTransaction;
 - (BOOL)beginImmediateTransaction;
 - (BOOL)beginExclusiveTransaction;
 - (BOOL)commit;
 - (BOOL)rollback;
 等等

开启事务 ：beginTransaction
回滚事务：rollback
提交事务：commit
(4) 事务代码
用事务处理一系列数据库操作，省时效率高
 
 比较结果如下：
 在事务中执行插入任务 所需要的时间 = 0.426221
 不在事务中执行插入任务 所需要的时间 = 0.790417

 */

/* <#注释#>
 查询多张表的多个字段值：
 NSString *sql = @"SELECT * FROM t_person1 WHERE age < 30;"
 "SELECT * FROM t_person2 WHERE age < 30;"
 "SELECT * FROM t_person3 WHERE age < 30;";
 
 [self.db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
 int ID = [resultsDictionary[@"id"] intValue];
 NSString *name = resultsDictionary[@"name"];
 int age = [resultsDictionary[@"age"] intValue];
 NSLog(@"name = %@, id = %d, age = %d", name, ID, age);
 return 0;
 }];
 */

#import <UIKit/UIKit.h>

@interface FMDBViewController : UIViewController

@end
