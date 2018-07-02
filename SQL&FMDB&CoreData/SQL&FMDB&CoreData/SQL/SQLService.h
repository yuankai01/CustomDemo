//
//  SQLService.h
//  Sqlite3
//
//  Created by mac on 13-12-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/* 注释 https://stackoverflow.com/questions/27383724/sqlite3-prepare-v2-sqlite3-exec
https://blog.csdn.net/zuoyou1314/article/details/38307865
 
 Few questions about sqlite3:
 1.When is necessary to use first approach one and when the other ? It is a difference between them?
 sqlite3_prepare_v2(_contactDB, sql_stmt_getIdRecepteur, -1, &sqlStatement, NULL);
 and
 if(sqlite3_prepare_v2(_contactDB, sql_stmt_getIdRecepteur, -1, &sqlStatement, NULL) == SQLITE_OK) {}
 
 2.When is most indicated to use 'sqlite3_exec' than 'sqlite3_prepare_v2' ?
 
 3.When is necessary to use first one, the second or the third:

 while(sqlite3_step(sqlStatement) == SQLITE_ROW){}  //
 if(sqlite3_step(sqlStatement) == SQLITE_ROW){}     //
 if(sqlite3_step(sqlStatement) == SQLITE_DONE){}    //
 
 回答：
 1、One should always check the return values of SQLite functions, in order to make sure it succeeded, thus the use of the if statement is greatly preferred. And if it failed, one would call  sqlite3_errmsg() to retrieve a C string description of the error.
 
 应该始终检查SQLite函数的返回值，以确保它成功，因此最好使用if语句。如果失败，可以调用sqlite3_errmsg()来检索错误的C字符串描述。
 
 2、One would use sqlite3_prepare_v2 (instead of sqlite3_exec) in any situation in which either:
  one is returning data and therefore will call sqlite3_step followed by one or more sqlite3_column_xxx functions, repeating that process for each row of data; or
 one is binding values to the ? placeholders in the SQL with sqlite3_bind_xxx.
  One can infer from the above that one would use sqlite3_exec only when (a) the SQL string has no parameters; and (b) the SQL does not return any data. The sqlite3_exec is simpler, but should only be used in these particular situations.
 
 Please note: That point regarding the ? placeholders is very important: One should avoid building SQL statements manually (e.g., with stringWithFormat or Swift string interpolation), especially if the values being inserted include end-user input. For example, if you call sqlite3_exec with INSERT, UPDATE, or DELETE statement that was created using user input (e.g., inserting some value provided by user into the database), you the very real possibility of problems arising from un-escaped quotation marks and escape symbols, etc. One is also exposed to SQL injection attacks.
 
 For example, if commentString was provided as a result of user input, this would be inadvisable:
 
 NSString *sql = [NSString stringWithFormat:@"INSERT INTO COMMENTS (COMMENT) VALUES ('%@')", commentString];
 if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
 NSLog(@"Insert failure: %s", sqlite3_errmsg(database));
 }
 Instead, you should:
 
 const char *sql = "INSERT INTO COMMENTS (COMMENT) VALUES (?)";
 if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
 NSLog(@"Prepare failure: %s", sqlite3_errmsg(database));
 }
 if (sqlite3_bind_text(statement, 1, [commentString UTF8String], -1, NULL) != SQLITE_OK) {
 NSLog(@"Bind 1 failure: %s", sqlite3_errmsg(database));
 }
 if (sqlite3_step(statement) != SQLITE_DONE) {
 NSLog(@"Step failure: %s", sqlite3_errmsg(database));
 }
 sqlite3_finalize(statement);
 Note, if this proper implementation felt like it was too much work, you could use the FMDB library, which would simplify it to:
 
 if (![db executeUpdate:@"INSERT INTO COMMENTS (COMMENT) VALUES (?)", commentString]) {
 NSLog(@"Insert failure: %@", [db lastErrorMessage]);
 }
 This provides the rigor of sqlite3_prepare_v2 approach, but the simplicity of the sqlite3_exec interface.

 /////////////
 在任何情况下，都可以使用sqlite3_prepare_v2(而不是sqlite3_exec):
  一个是返回数据，因此将调用sqlite3_step，然后是一个或多个sqlite3_column_xxx函数，对每一行数据重复这个过程;或
 一个是绑定值到?SQL中的占位符使用sqlite3_bind_xxx。
 从上面可以推断，只有当(a) SQL字符串没有参数时才会使用sqlite3_exec;(b) SQL不返回任何数据。sqlite3_exec更简单，但应该只在这些特定情况下使用。
 
 请注意:那点关于?占位符非常重要:应该避免手工构建SQL语句(例如，使用stringWithFormat或Swift字符串插补)，特别是如果插入的值包含最终用户输入。举个例子,如果你叫sqlite3_exec插入、更新或删除语句创建使用用户输入(例如,插入一些用户到数据库中)所提供的价值,你的真正可能性中出现的问题没有转义引号转义符号,等。一个也暴露于SQL注入攻击。
 
 例如，如果是用户输入的结果提供了commentString，则不建议这样做:
 
 NSString *sql = [NSString stringWithFormat:@"插入到注释(注释)值('%@')"commentString);
 if (sqlite3_exec(数据库，[sql UTF8String]， NULL, NULL, NULL) != SQLITE_OK)
 NSLog(@插入失败:% s,sqlite3_errmsg(数据库);
 }
 相反,你应该:
 
 const char *sql = "INSERT INTO COMMENTS (COMMENT) VALUES (?)";
 if (sqlite3_prepare_v2(database, sql， -1， &statement, NULL) != SQLITE_OK)
 NSLog(@准备失败:% s,sqlite3_errmsg(数据库);
 }
 if (sqlite3_bind_text(语句，1，[commentString UTF8String]， -1, NULL) != SQLITE_OK)
 NSLog(@“绑定1失败:%s”，sqlite3_errmsg(数据库));
 }
 if (sqlite3_step(语句)!= SQLITE_DONE)
 NSLog(@步骤失败:% s,sqlite3_errmsg(数据库);
 }
 sqlite3_finalize(声明);
 注意，如果这个适当的实现感觉工作量太大，您可以使用FMDB库，它将简化为:
 
 如果(![db executeUpdate:@"插入注释(注释)值(?)",commentString]){
 NSLog(@“插入失败:%@”，[db lastErrorMessage]);
 }
 这提供了sqlite3_prepare_v2方法的严格性，但是提供了sqlite3_exec接口的简单性。
 
 3、When retrieving multiple rows of data, one would use:
 
 while(sqlite3_step(sqlStatement) == SQLITE_ROW) { ... }
 Or, better, if you wanted to do the proper error handling, you'd do:
 
 int rc;
 while ((rc = sqlite3_step(sqlStatement)) == SQLITE_ROW) {
 // process row here
 }
 if (rc != SQLITE_DONE) {
 NSLog(@"Step failure: %s", sqlite3_errmsg(database));
 }
 
 When retrieving a single row of data, one would:
 
 if (sqlite3_step(sqlStatement) != SQLITE_ROW) {
 NSLog(@"Step failure: %s", sqlite3_errmsg(database));
 }
 When performing SQL that will not return any data, one would:
 
 if (sqlite3_step(sqlStatement) != SQLITE_DONE) {
 NSLog(@"Step failure: %s", sqlite3_errmsg(database));
 }
 
 ///////////////////////////
 当检索多行数据时，可以使用:
 while(sqlite3_step(sqlStatement) == SQLITE_ROW){…}
 或者，如果你想做正确的错误处理，你最好:
 
 int rc;
 while(rc = sqlite3_step(sqlStatement)) = SQLITE_ROW)
 / /行
 }
 if (rc != SQLITE_DONE)
 NSLog(@步骤失败:% s,sqlite3_errmsg(数据库);
 }
 当检索一行数据时，可以:
 if (sqlite3_step(sqlStatement) != SQLITE_ROW) {
 NSLog(@步骤失败:% s,sqlite3_errmsg(数据库);
 }
 当执行不返回任何数据的SQL时，会:
 
 if (sqlite3_step(sqlStatement) != SQLITE_DONE)
 NSLog(@步骤失败:% s,sqlite3_errmsg(数据库);
 }
 */

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class PassValue;

@interface SQLService : NSObject
{
    sqlite3 *sqliteDB;
}

-(BOOL)openSQL;
-(void)creatSQLTable;
-(void)searchDatabase:(NSInteger)age;
-(BOOL)insertData:(PassValue *)value;
-(void)delteData:(NSInteger)age;
-(void)modifyData:(PassValue *)value;

@end


@interface PassValue : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSString *sex;

@end
