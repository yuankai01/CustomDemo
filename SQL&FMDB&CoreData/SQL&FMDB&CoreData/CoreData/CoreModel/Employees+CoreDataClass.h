//
//  Employees+CoreDataClass.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//
//

/* 删除多余的版本model https://stackoverflow.com/questions/7708392/how-to-delete-an-old-unused-data-model-version-in-xcode
1、Set the Current version of the model in Xcode to one that you want to keep
2、Remove the .xcdatamodeld from your project (Right-click -> Delete -> Remove Reference Only)
3、Show the contents of the .xcdatamodeld package in the Finder (Right-click -> Show Package Contents)
4、Delete the .xcdatamodel file(s) that you don't want anymore
5、Re-add the .xcdatamodeld file to your projec
 
 1、在Xcode中选中当前要删除版本的Model
 2、从工程中删除.xcdatamodeld引用，注意仅仅是删除引用
 3、在工程文件夹内显示.xcdatamodeld包内容（右键单击 - 显示报内容）
 4、删除你不想要的版本model
 5、重新添加.xcdatamodeld Model到工程文件中
 
 或者
 1、在Xcode中选中当前要删除版本的Model、 右键点击 show in finder （里面会看到创建的几个版本model）
 2、删除.xcdatamodeld引用，注意仅仅是删除引用
 3、在1中显示的文件夹内删除你不想要的版本Model version model
 4、重新添加.xcdatamodeld Model到工程文件中
 
 注：有时候重新添加完.xcdatamodeld Model到工程后，重新点击model的实体Entity，show the data model inspector，显示是空的，重启Xcode就好了。
 
 对于Xcode中对model file所做的修改有时往往不能被正确保存，我们需要做以下步骤来确保：
 1、点击Xcode->File->save菜单
 2、清空项目文件夹
 3、重启Xcode查看修改是否真正被应用
 4、添加的Model版本，如果源model的codegen是手动的，则新生产的Model的codegen默认和原来版本不一样，如果在新建实体类，则会包编译重复错误。解决办法，把对应的实体改为手动codegen选项改成Manual/None。
 
 xcode8默认会自动给CoreData数据模型文件添加NSManagedObject子类文件，如果手动在Editor->Create NSManagedObject SubClass...导出文件，编译时就会报文件重复的错误，解决办法就是在数据库模型文件的右侧，将codegen选项改成Manual/None表示不需要xcode自动创建，由自己手动创建。
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employees : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Employees+CoreDataProperties.h"
