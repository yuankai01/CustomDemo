//
//  Employees+CoreDataProperties.m
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Employees+CoreDataProperties.h"

@implementation Employees (CoreDataProperties)

+ (NSFetchRequest<Employees *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employees"];
}

/* 注释
 在声明property属性后，有2种实现选择
 @synthesize (Xcode6以后省略这个了, 默认在 @implementation .m中添加这个@synthesize xxx = _xxx; )
 编译器期间，让编译器自动生成getter/setter方法。
 当有自定义的存或取方法时，自定义会屏蔽自动生成该方法
 
 @dynamic (Xcode6以后省略这个了, 默认在 @implementation .m中添加这个@synthesize xxx; )
 告诉编译器，不自动生成getter/setter方法，避免编译期间产生警告
 然后由自己实现存取方法
 或存取方法在运行时动态创建绑定：主要使用在CoreData的实现NSManagedObject子类时使用，由Core Data框架在程序运行的时动态生成子类属性
 
 */
//自动生成的 @dynamic 声明 需要手动写set/get方法
@dynamic name;
@dynamic age;
@dynamic sex;
@dynamic address;
@dynamic phone;
@dynamic workNum;

@end
