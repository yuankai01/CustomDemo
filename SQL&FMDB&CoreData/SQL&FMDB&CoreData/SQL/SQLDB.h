//
//  SQLDB.h
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

/* SQL 常用语句 
 0、创建数据库：sqlite3_open 打开即创建
 //1.打开数据库(如果指定的数据库文件存在就直接打开，不存在就创建一个新的数据文件)
 //参数1:需要打开的数据库文件路径(iOS中一般将数据库文件放到沙盒目录下的Documents下)
 
 //参数2:指向数据库变量的指针的地址
 //返回值:数据库操作结果
 int ret = sqlite3_open([sqlPath UTF8String], &db);
 
 1、创建数据表：char *sql = "CREATE TABLE IF NOT EXISTS testTable(ID INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Age INT,Sex TEXT,Score INT)";
 1.1、删除数据表：const char *sql = "DROP TABLE if EXISTS t_Student";
 
 2、插入数据：char *sql = "INSERT INTO testTable(Name,Age,Sex) VALUES (?,?,?)";//必须保证几个问号，对应前面几个参数,并注意逗号的语法拼写。插入数据的参数个数不能大于创建表时对应的参数个数。
 3、查询数据：char *sql = "SELECT id,name,score FROM testTable WHERE  age = ?";
 4、删除数据：char *sql = "DELETE FROM testTable WHERE age = ?";
 5、更改数据：char *sql = "UPDATE testTable SET Name = ? WHERE age = ? and sex = ?";
 
 6、查询多张表的多个字段值：
 NSString *sql = @"SELECT * FROM t_person1 WHERE age < 30;"
 "SELECT * FROM t_person2 WHERE age < 30;"
 "SELECT * FROM t_person3 WHERE age < 30;";
 */

/* <#注释#>
 8）其他功能
 起别名：
 select 字段1 别名 , 字段2 别名 , … from 表名 别名 ;
 select 字段1 别名, 字段2 as 别名, … from 表名 as 别名 ;
 select 别名.字段1, 别名.字段2, … from 表名 别名 ;
 计算记录的数量
 select count (字段) from 表名 ;
 select count ( * ) from 表名 ;
 查询出来的结果可以用order by进行排序
 select * from t_student order by 字段 ;
 select * from t_student order by age ;
 
 默认是按照升序排序（由小到大），也可以变为降序（由大到小）
 select * from t_student order by age desc ;  //降序
 select * from t_student order by age asc ;   // 升序（默认）
 
 也可以用多个字段进行排序
 select * from t_student order by age asc, height desc ;
 先按照年龄排序（升序），年龄相等就按照身高排序（降序）
 使用limit可以精确地控制查询结果的数量，比如每次只查询10条数据
 格式: select * from 表名 limit 数值1, 数值2 ;
 示例:
 select * from t_student limit 4, 8 ;
 可以理解为：跳过最前面4条语句，然后取8条记录
 建表时可以给特定的字段设置一些约束条件，常见的约束有
 not null ：规定字段的值不能为null
 unique ：规定字段的值必须唯一
 default ：指定字段的默认值
 （建议：尽量给字段设定严格的约束，以保证数据的规范性）
 主键约束：
 良好的数据库编程规范应该要保证每条记录的唯一性，为此，增加了主键约束
 也就是说，每张表都必须有一个主键，用来标识记录的唯一性
 
 什么是主键
 主键（Primary Key，简称PK）用来唯一地标识某一条记录
 例如t_student可以增加一个id字段作为主键，相当于人的身份证
 主键可以是一个字段或多个字段
 
 作者：或跃在渊
 链接：https://www.jianshu.com/p/0c51402ee93b
 來源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

#import <Foundation/Foundation.h>

@interface SQLDB : NSObject

@end

#pragma mark - 创建一个学生表 **********
@interface Employee : NSObject

@property (assign, nonatomic) int stuId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *age;

@end
