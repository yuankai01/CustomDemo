//
//  CoreDataViewController.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//
//coreData查看工具 ： https://github.com/ChristianKienle/Core-Data-Editor

/* https://www.cnblogs.com/xujiahui/p/6408747.html
 SQLite重要框架FMDB的使用.但对比SQLite,CoreData有下面几个优势。第一是CoreData作为苹果提供的原生框架，在内存方法比SQLite有性能上的优势。第二是CoreData操作数据不需要使用SQLite代码，使用方便。第三是CoreData把数据用面向对象方式进行管理，操作数据库更方便。
 CoreData的核心是Core Data stack(技术栈堆)。CoreData就是依靠Core Data stack中的几个对象进行数据操作的。
 */
/* 注释 https://www.jianshu.com/p/d5030eb30562
 CoreData 从入门到精通 （一） 数据模型 + CoreData 栈的创建
 
 https://www.jianshu.com/p/9f1828d49cf5
 CoreData 从入门到精通（二） 数据的增删改查
 
 https://www.jianshu.com/p/f298f5076384
 CoreData 从入门到精通（三）关联表的创建
 
 https://www.jianshu.com/p/0cb4540e9d65
 CoreData 从入门到精通（四）并发操作
 
 https://www.jianshu.com/p/7c16797208b0
 CoreData 从入门到精通（五）CoreData 和 TableView 结合
 
 https://www.jianshu.com/p/da6f49dccf17
 CoreData 从入门到精通（六）模型版本和数据迁移
 
 */


/* 注释 https://blog.csdn.net/willluckysmile/article/details/76464249
 ios10.3之CoreData的详细教程
 
 
 */

/* 注释  http://www.demodashi.com/demo/11041.html
 iOS CoreData (一) 增删改查
 
 Core Data是iOS5之后才出现的一个框架，本质上是对SQLite的一个封装，它提供了对象-关系映射(ORM)的功能，即能够将OC对象转化成数据，保存在SQLite数据库文件中，也能够将保存在数据库中的数据还原成OC对象，通过CoreData管理应用程序的数据模型，可以极大程度减少需要编写的代码数量！
 */
/* 创建CoreDateModel 方法
 1、创建工程的时候勾选CoreData
 2、New - File - iOS - CoreData <Data Molde / Mapping Model 两个可选，一般建Data Molde>
 */

/* 注释 
 生成上下文 关联数据库
 NSManagedObjecption 表格实体结构
 */

/* 注释
 xcode8默认会自动给CoreData数据模型文件添加NSManagedObject子类文件，如果手动在Editor->Create NSManagedObject SubClass...导出文件，编tContext 管理对象，上下文，持久性存储模型对象，处理数据与应用的交互
 NSManagedObjectModel 被管理的数据模型，数据结构
 NSPersistentStoreCoordinator 添加数据库，设置数据存储的名字，位置，存储方式
 NSManagedObject 被管理的数据记录
 NSFetchRequest 数据请求
 NSEntityDescri译时就会报文件重复的错误，解决办法就是在数据库模型文件的右侧，将codegen选项改成Manual/None表示不需要xcode自动创建，由自己手动创建。
 */

/* Z_PK  Z_ENT  Z_OPT
 https://blog.csdn.net/u012844004/article/details/52217065
 https://blog.csdn.net/meegomeego/article/details/8530289
 
 CoreData
 
 Z_PK     是表的主键，从1开始递增，唯一值
 Z_ENT  表在xcdatamodel 中的索引值，创建了5个表，Z_ENT的区间就是[1,5]
 Z_OPT  表示的是每条数据被操作的次数，初始化值为1，只要是增删改查都会加1
 
 ios开发在使用CoreData进行本地存储，在sqlite文件的表结构中会看到 Z_PK,Z_ENT,Z_OPT三个字段并不是我们自己写的表存储字段。
 如下图所示:z_pk.png.
 Z_PK是表的主键，Z_ENT是表在xcdatamodel 中的索引值，Z_OPT是每条数据被操作的次数，初始化值为1，每次进行对该条数据的增删改查则加1。
 */

#import <UIKit/UIKit.h>

@interface CoreDataViewController : UIViewController

@end
