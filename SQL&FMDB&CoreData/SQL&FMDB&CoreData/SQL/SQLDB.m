//
//  SQLDB.m
//  SQL&CoreData&FMDB
//
//  Created by Gao on 2018/6/8.
//  Copyright © 2018年 Gao. All rights reserved.
//

/* <#注释#>
 
 作者：隔壁王叔不在家
 链接：https://www.jianshu.com/p/cf76e2e81230
 來源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

#import "SQLDB.h"
#import <sqlite3.h>

// 创建数据库指针
static sqlite3 *db = nil;

@implementation SQLDB

// 打开数据库
+ (sqlite3 *)open {
    
    // 此方法的主要作用是打开数据库
    // 返回值是一个数据库指针
    // 因为这个数据库在很多的SQLite API（函数）中都会用到，我们声明一个类方法来获取，更加方便
    
   
    // 懒加载
    if (db != nil) {
        return db;
    }
    
    // 获取Documents路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    
    // 生成数据库文件在沙盒中的路径
    NSString *sqlPath = [docPath stringByAppendingPathComponent:@"studentDB.sqlite"];
    
    // 创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 判断沙盒路径中是否存在数据库文件，如果不存在才执行拷贝操作，如果存在不在执行拷贝操作
    if ([fileManager fileExistsAtPath:sqlPath] == NO) {
        // 获取数据库文件在包中的路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"studentDB" ofType:@"sqlite"];
        
        // 使用文件管理对象进行拷贝操作
        // 第一个参数是拷贝文件的路径
        // 第二个参数是将拷贝文件进行拷贝的目标路径
        [fileManager copyItemAtPath:filePath toPath:sqlPath error:nil];
        
    }
    
    // 打开数据库需要使用一下函数
    // 第一个参数是数据库的路径（因为需要的是C语言的字符串，而不是NSString所以必须进行转换）
    // 第二个参数是指向指针的指针
    //sqlite3_open函数执行后，如果没有数据库的话就自动创建。
    
    //1.打开数据库(如果指定的数据库文件存在就直接打开，不存在就创建一个新的数据文件)
    //参数1:需要打开的数据库文件路径(iOS中一般将数据库文件放到沙盒目录下的Documents下)
    
    //参数2:指向数据库变量的指针的地址
    //返回值:数据库操作结果
    int ret = sqlite3_open([sqlPath UTF8String], &db);
    
    //判断执行结果
    if (ret == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
    
    return db;
}

// 关闭数据库
+ (void)close {
    // 关闭数据库
    sqlite3_close(db);
    
    // 将数据库的指针置空
    db = nil;
    
//    int result = sqlite3_close(db);
//    if (result == SQLITE_OK) {
//
//        //  把指针 重置为空 方便下次打开
//        db = nil;
//
//        NSLog(@"关闭数据库成功");
//
//    } else {
//        NSLog(@"关闭数据库失败");
//    }
}


@end

#pragma mark - 创建一个学生表 **********
@implementation Employee

+ (Employee *)studentWithID:(int)keyId name:(NSString *)name gender:(NSString *)gender
{
    Employee *student = [[Employee alloc] init];
    student.stuId = keyId;
    student.name = name;
    student.gender = gender;
    
    return student;
}

#pragma 执行SQL语句
-(BOOL)execSQL:(NSString *)SQL{
    return sqlite3_exec([SQLDB open], SQL.UTF8String, nil, nil, nil) == SQLITE_OK;
}

// 创建表
/* 格式：
 create table 表名 (字段名1 字段类型1, 字段名2 字段类型2, …) ;
 create table if not exists 表名 (字段名1 字段类型1, 字段名2 字段类型2, …) ;
 */
- (void)createTable {
    
    // 将建表的sql语句放入NSString对象中
    NSString *sql = @"create table if not exists stu (ID integer primary key, name text not null, gender text default '男')";
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    // 执行sql语句
    //通过sqlite3_exec方法可以执行 (创建表、数据的插入、数据的删除以及数据的更新) 操作；
    //但是数据查询的sql语句不能使用这个方法来执行,用的是sqlite3_prepare_v2方法
    
    //参数1:数据库指针(需要操作的数据库)
    //参数2:需要执行的sql语句
    //返回值:执行结果
    int result = sqlite3_exec(db, sql.UTF8String, nil, nil, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    } else {
        NSLog(@"建表失败");
    }
    
    // 关闭数据库
    [SQLDB close];
    
    /* 注释
     SQLite将数据划分为以下几种存储类型：
     integer：整型值
     real：浮点值
     text：文本字符串
     blob：二进制数据（比如文件）
     注：实际上Sqlite是无类型的，就算声明为integer类型，还是能存储字符串文本（主键除外）
     即建表时声明啥类型或者不声明类型都可以，但是为了保持良好的编程规范、方便程序猿之间交流，
     编写建表语句的时候最好都加上每个字段的具体类型
     
     */
}

//删除表
/* 格式：
 drop table 表名 ;
 drop table if exists 表名 ;
 */
- (void)deleteTable {
    const char *sql = "DROP TABLE if EXISTS t_Student;";
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    int ret = sqlite3_exec(db, sql, NULL, NULL, NULL);
    if (ret == SQLITE_OK) {
        NSLog(@"删除表格成功");
    } else {
        NSLog(@"删除表格失败");
    }
}

// 插入一条记录
/* 格式：
 insert into 表名 (字段1, 字段2, …) values (字段1的值, 字段2的值, …) ;
 */
+ (void)insertStudentWithID:(int)ID name:(NSString *)name gender:(NSString *)gender {
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "insert into Students values(?,?,?)", -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        // 绑定
        sqlite3_bind_int(stmt, 1, ID);
        sqlite3_bind_text(stmt, 2, [name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [gender UTF8String], -1, nil);
        
        // 插入与查询不一样，执行结果没有返回值
        sqlite3_step(stmt);
        
    }
    
    // 释放语句对象
    sqlite3_finalize(stmt);
    
}

// 根据指定ID删除学生
/* 格式：
 delete from 表名 ;注：删除的是表中的所有记录
 可以添加条件语句，选择性的删除
 
 条件语句常见格式：
 where 字段 = 某个值 ; if(字段==某个值) // 不能用两个 =
 where 字段 is 某个值 ; // is 相当于 =
 where 字段 != 某个值 ;
 where 字段 is not 某个值 ; // is not 相当于 !=
 where 字段 > 某个值 ;
 where 字段1 = 某个值 and 字段2 > 某个值 ; // and相当于C语言中的 &&
 where 字段1 = 某个值 or 字段2 = 某个值 ; // or 相当于C语言中的 ||
 
 */
+ (void)deleteStudentByID:(int)ID {
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "delete from Students where ID = ?", -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, ID);
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    
}

// 更新指定ID下的姓名和性别
+ (void)updateStudentName:(NSString *)name gender:(NSString *)gender forID:(int)ID {
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "update Student set name = ?, gender = ? where ID = ?", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [gender UTF8String], -1, nil);
        sqlite3_bind_int(stmt, 3, ID);
        
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

//查询
// 根据指定的ID，查找相对应的学生
+ (Employee *)findStudentByID:(int)ID {
    
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    Employee *student = nil;
    
    //查询
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    //2.执行sql语句
    //参数1:数据库
    //参数2:sql语句
    //参数3:sql语句的长度(-1自动计算)
    //参数4:结果集(用来收集查询结果)
    //    sqlite3_stmt * stmt;
    //参数5:NULL
    //返回值:执行结果
    int result = sqlite3_prepare_v2(db, "select * from Students where ID = ?", -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        
        // 如果查询语句或者其他sql语句有条件，在准备语句对象的函数内部，sql语句中用？来代替条件，那么在执行语句之前，一定要绑定
        // 1代表sql语句中的第一个问号，问号的下标是从1开始的
        sqlite3_bind_int(stmt, 1, ID);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 获取记录中的字段信息
            const unsigned char *cName = sqlite3_column_text(stmt, 1);
            const unsigned char *cGender = sqlite3_column_text(stmt, 2);
            
            // 将C语言字符串转换成OC字符串
            NSString *name = [NSString stringWithUTF8String:(const char *)cName];
            NSString *gender = [NSString stringWithUTF8String:(const char *)cGender];
            
            student = [Employee studentWithID:ID name:name gender:gender];
        }
    }
    
    // 先释放语句对象
    sqlite3_finalize(stmt);
    
    return student;
    
}

// 获取表中保存的所有学生
//查询数据
/* <#注释#>
 6）更新数据
 格式：update 表名 set 字段1 = 字段1的新值, 字段2 = 字段2的新值, … ;
 7）查询数据
 格式：SELECT 字段1，字段2 FROM 表名；
 查询多个字段中间用英文逗号隔开
 
 //关联数据表 格式和之前一样，表中间用逗号隔开
 格式：SELECT 字段1，字段2 FROM 表1，表2；
 //people,region是两个表，name是表people中的字段,regioninfo是表region中的字段。 select name,regioninfo from people,region where people.region=region.regionid and region.regioninfo="beijing";
 
 //遍历查询结果sqlite3_step
 
 */
+ (NSArray *)allStudents
{
    // 打开数据库
    sqlite3 *db = [SQLDB open];
    
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    //2.执行sql语句
    //参数1:数据库
    //参数2:sql语句
    //参数3:sql语句的长度(-1自动计算)
    //参数4:结果集(用来收集查询结果)
    //    sqlite3_stmt * stmt;
    //参数5:NULL
    //返回值:执行结果
    
    int result = sqlite3_prepare_v2(db, "select * from Students", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        
        // SQLite_ROW仅用于查询语句，sqlite3_step()函数执行后的结果如果是SQLite_ROW，说明结果集里面还有数据，会自动跳到下一条结果，如果已经是最后一条数据，再次执行sqlite3_step()，会返回SQLite_DONE，结束整个查询
        //sqlite3_step 遍历
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 获取记录中的字段值
            // 第一个参数是语句对象，第二个参数是字段的下标，从0开始
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *cName = sqlite3_column_text(stmt, 1);
            const unsigned char *cGender = sqlite3_column_text(stmt, 2);
            
            // 将获取到的C语言字符串转换成OC字符串
            NSString *name = [NSString stringWithUTF8String:(const char *)cName];
            NSString *gender = [NSString stringWithUTF8String:(const char *)cGender];
            Employee *student = [Employee studentWithID:ID name:name gender:gender];
            
            // 添加学生信息到数组中
            [mArr addObject:student];
        }
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    
    return mArr;
}

@end
