//
//  Course+CoreDataProperties.m
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/15.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Course"];
}

@dynamic score;
@dynamic courseId;
@dynamic courseName;
@dynamic courseStudents;

@end
