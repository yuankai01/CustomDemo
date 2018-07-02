//
//  SQLService.m
//  Sqlite3
//
//  Created by mac on 13-12-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SQLService.h"

#define FileName @"sql_db.sqlite"

@implementation SQLService

#pragma mark - 获取路径名
-(NSString *)getFilePath
{
    NSString *path = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0];
    NSString *databasePath = [path stringByAppendingPathComponent:FileName];
    
    NSLog(@"sql db path === %@",databasePath);
    
    return databasePath;
}

#pragma mark - 预编译SQL语句 解析执行SQL语句,返回sqlite3_stmt
-(sqlite3_stmt *)parseSQL:(char *)sql
{
    sqlite3_stmt *statement;
    int stmt = sqlite3_prepare_v2(sqliteDB, sql, -1, &statement, nil);
    NSLog(@"stmt == %d",stmt);
    /* beginning-of-error-codes */
    //#define SQLITE_OK           0   /* Successful result */
    //#define SQLITE_ERROR        1   /* SQL error or missing database */
    
    //stmt = 0 是成功，1是失败
    
    return statement;
}

//********************
#pragma mark - 打开数据库文件，如果不存在，则直接创建数据库文件
-(BOOL)openSQL
{
    NSString *fileName = [self getFilePath];
    sqlite3_open([fileName UTF8String], &sqliteDB);
    
    [self creatSQLTable];
    
    sqlite3_close(sqliteDB);
    
    return YES;
}

#pragma mark - 创建数据表
/* 创建表时会自动生成sqlite_sequence表
 sqlite_sequence表也是SQLite的系统表。初始化时是没有数据的，当往自建的表填充数据后，sqlite_sequence表会生成对应的数据：表名：name;操作记录次数：seq。
 该表用来保存其他表的RowID的最大值。数据库被创建时，sqlite_sequence表会被自动创建。该表包括两列。第一列为name，用来存储表的名称。第二列为seq，用来保存表对应的RowID的最大值（操作记录的次数）。该值最大值为9223372036854775807。当对应的表增加记录，该表会自动更新。当表删除，该表对应的记录也会自动删除。如果该值超过最大值，会引起SQL_FULL错误。所以，一旦发现该错误，用户不仅要检查SQLite文件所在的磁盘空间是否不足，还需要检查是否有表的ROWID达到最大值。
 */
-(void)creatSQLTable
{
    char *sql = "CREATE TABLE IF NOT EXISTS testTable(ID INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,age INT,Sex TEXT,Score INT)";
    sqlite3_stmt *statement = [self parseSQL:sql];
    /*
     char *errorMsg;
     const char *createSQL = "CREATE TABLE IF NOT EXISTS PEOPLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIELD_DATA TEXT)";
     int result = sqlite3_exec(database, createSQL, NULL, NULL, &errorMsg);
     
     执行之后，如果result的值是SQLITE_OK，则表明执行成功；否则，错误信息存储在errorMsg中。
     sqlite3_exec这个方法可以执行那些没有返回结果的操作，例如创建、插入、删除等。
     */
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
}

#pragma mark - 向数据表中插入数据
-(BOOL)insertData:(PassValue *)value
{
    //打开数据库
    sqlite3_open([self getFilePath].UTF8String, &sqliteDB);
    NSLog(@"insert open == %d",sqlite3_open([self getFilePath].UTF8String, &sqliteDB));
    //向表中插入数据,首先得有表才能插入，所以在插入数据前要创建表。
    [self creatSQLTable];
    
    char *sql = "INSERT INTO testTable(Name,Age,Sex) VALUES (?,?,?)";//必须保证几个问号，对应前面几个参数,并注意逗号的语法拼写。插入数据的参数个数不能大于创建表时对应的参数个数。
    sqlite3_stmt *statement = [self parseSQL:sql];

    //绑定数据，//这里的数字1，2，3代表第几个问号，绑定数据个数可以和SQL插入语句不一致。
    sqlite3_bind_text(statement, 1, [value.name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(statement, 2, (int)value.age);
    sqlite3_bind_text(statement, 3, [value.sex UTF8String], -1, SQLITE_TRANSIENT);
    
    //执行statement ？？ 执行sql文
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);    //释放sql文资源

    //关闭数据库
    sqlite3_close(sqliteDB);
    
    if (success == SQLITE_DONE) {
        return YES;
    }
    
    return NO;
}

#pragma mark - 查询数据
-(void)searchDatabase:(NSInteger)age
{
    if (sqlite3_open([self getFilePath].UTF8String, &sqliteDB) == SQLITE_OK)
    {
        char *sql = "SELECT name,age,sex FROM testTable WHERE age > ?";
        sqlite3_stmt *statement = [self parseSQL:sql];
       
        sqlite3_bind_int(statement, 1, (int)age);
//        sqlite3_bind_text(statement, 1, [sex UTF8String], -1, SQLITE_TRANSIENT);
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *name = (char *)sqlite3_column_text(statement, 0);
            NSString *strName = [NSString stringWithUTF8String:name];
            char *age = (char *)sqlite3_column_text(statement, 1);
            char *sex = (char *)sqlite3_column_text(statement, 2);
            //第二个参数从0开始起，是SELECT查询语句筛选数据的索引数，而不是创建表或插入数据时对应的参数索引数。
            //此处查询语句查询的是姓名、年龄、性别；如果要查询所有直接用星号标示SELECT *
            NSLog(@"%s == %s == %s", name, age, sex);
        }
        
        sqlite3_close(sqliteDB);
    }
}

#pragma mark - 删除数据
-(void)delteData:(NSInteger)age
{
    if (sqlite3_open([self getFilePath].UTF8String, &sqliteDB) == SQLITE_OK) {
        char *sql = "DELETE FROM testTable WHERE age > ?";
        sqlite3_stmt *statement = [self parseSQL:sql];

        sqlite3_bind_int(statement, 1, (int)age);    //把参数age传到执行语句中，强转为int类型

        //删除单条数据
//        int delete = sqlite3_step(statement);
//        if (delete == SQLITE_OK) {
//            NSLog(@"删除成功");
//            sqlite3_finalize(statement);
//            sqlite3_close(sqliteDB);
//        }else
//        {
//            NSLog(@"删除失败 === %d",delete);
//        }
        
        //多行删除 ？？？？
        if (sqlite3_step(statement) == SQLITE_ROW) {
            NSLog(@"删除成功");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(sqliteDB);
        
//        //  sqlite3_exec：只有特定条件下使用比较简单：a、没有参数；b、没有返回值；而sqlite3_prepare_v2可以在任何条件下使用
//        int result = sqlite3_exec(sqliteDB, sql, NULL, NULL, NULL);
//        if (result == SQLITE_OK) {
//            NSLog(@"删除成功");
//        } else {
//            NSLog(@"删除失败");
//        }
    }
}

#pragma mark - 更改数据
-(void)modifyData:(PassValue *)value
{
    if (sqlite3_open([self getFilePath].UTF8String, &sqliteDB) == SQLITE_OK)
    {
        char *sql = "UPDATE testTable SET name = ?, age = ? WHERE sex = ?";
        sqlite3_stmt *statement = [self parseSQL:sql];
        
        sqlite3_bind_text(statement, 1, [value.name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, (int)value.age);
        sqlite3_bind_text(statement, 3, [value.sex UTF8String], -1, SQLITE_TRANSIENT);

//        int modify = sqlite3_step(statement) ;
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(sqliteDB);
    }
}

@end

@implementation PassValue


@end
