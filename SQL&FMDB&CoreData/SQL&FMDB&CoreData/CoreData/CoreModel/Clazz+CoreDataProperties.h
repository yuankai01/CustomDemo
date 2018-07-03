//
//  Clazz+CoreDataProperties.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/12.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Clazz+CoreDataClass.h"

@class Student;
NS_ASSUME_NONNULL_BEGIN

@interface Clazz (CoreDataProperties)

+ (NSFetchRequest<Clazz *> *)fetchRequest;

@property (nonatomic) int16_t classId;
@property (nullable, nonatomic, copy) NSString *cName;
@property (nullable, nonatomic, retain) NSSet<Student *> *classStudents;

@end

@interface Clazz (CoreDataGeneratedAccessors)

- (void)addClassStudentsObject:(Student *)value;
- (void)removeClassStudentsObject:(Student *)value;
- (void)addClassStudents:(NSSet<Student *> *)values;
- (void)removeClassStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
