//
//  SQLViewController.h
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

/* 引用网址
 https://www.jianshu.com/p/0c51402ee93b
 https://www.jianshu.com/p/cf76e2e81230
 
 1、什么是SQLite
 SQLite是一款轻型的嵌入式数据库
 它占用资源非常低，在嵌入式设备中，可能只需要几百K的内存就够了
 它的处理速度比MySQL、PostgreSQL这两款著名的数据库都还快
 
 2、什么是数据库
 数据库（Database）是按照数据结构来组织、存储和管理数据的仓库
 数据库可以分为2大种类：
 (1)关系型数据库（主流）
 (2)对象型数据库
 (3)层次式数据库
 
 常用关系型数据库
 PC端：Oracle、MySQL、SQL Server、Access、DB2、Sybase
 
 移动客户端\嵌入式：SQLite
 
 3.如何存储数据
 数据库的存储结构和excel很像，以表（table）为单位，一般步骤是：
 (1)新建一张表(table)
 (2)添加多个字段(column， 列， 属性)
 (3)添加多行记录(row， 每行存放多个字段对应的值)
 
 4.SQLite语句的特点及其关键字：
 特点：
 (1) 不区分大小写(比如数据库认为user和UsEr是一样的)
 (2)每条语句都必须以分号 ‘; ’结尾
 
 SQLite是无类型的数据库，可以保存任何类型的数据，对于SQLite来说对字段不指定类型是完全有效的.
 
 常用的关键字：
 select、insert、update、delete、from、create、where、desc、order、by、group、table、alter、view、index等等
 注：数据库中不可以使用关键字来命名表、字段

 SQL的语句我们可以分成两个部分来看，分别是：数据操作语言（DML）和数据定义语言（DDL）.
 
 查询和更新指令构成了SQL的DML部分：
 数据插入命令——insert
 数据库更新命令——update
 数据库删除命令——delete
 数据库检索命令——select
 
 DDL部分是我们有能力创建或删除表格，我们也可以定义索引，规定表之间的链接，以及施加表间的约束
 创建数据库命令——create database
 修改数据库命令——alter database
 
 创建新表的命令——create table
 变更数据库中的表——alter table
 删除表——drop table
 创建索引——create index
 删除索引——drop index
 
 SQLite字段约束条件:
 not null - 非空
 unique - 唯一
 primary key - 主键
 foreign key - 外键
 check - 条件检查，确保一列中的所有值满足一定条件
 default - 默认
 autoincreatement - 自增型变量
 
 三、iOS的数据库技术的实现
 
 开始使用SQLite所需要的几个步骤
 
 需要的框架：libsqlite3.0.tbd
 
 引入<sqlite3.h>头文件
 打开创建数据库
 执行SQL命令——创建表，增删改查等操作
 关闭数据库

 */

#import <UIKit/UIKit.h>

@interface SQLViewController : UIViewController

@end
