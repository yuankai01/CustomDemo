//
//  Student+CoreDataProperties.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/12.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *studentId;
@property (nullable, nonatomic, retain) Clazz *studentClass;
@property (nullable, nonatomic, retain) NSSet<Course *> *studentCourses;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addStudentCoursesObject:(Course *)value;
- (void)removeStudentCoursesObject:(Course *)value;
- (void)addStudentCourses:(NSSet<Course *> *)values;
- (void)removeStudentCourses:(NSSet<Course *> *)values;

@end

NS_ASSUME_NONNULL_END
