//
//  Student+CoreDataProperties.m
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/12.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic age;
@dynamic name;
@dynamic sex;
@dynamic studentId;
@dynamic studentClass;
@dynamic studentCourses;

@end
