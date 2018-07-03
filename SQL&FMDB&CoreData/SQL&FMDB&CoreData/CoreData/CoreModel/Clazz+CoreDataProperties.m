//
//  Clazz+CoreDataProperties.m
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/12.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Clazz+CoreDataProperties.h"

@implementation Clazz (CoreDataProperties)

+ (NSFetchRequest<Clazz *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Clazz"];
}

@dynamic classId;
@dynamic cName;
@dynamic classStudents;

@end
