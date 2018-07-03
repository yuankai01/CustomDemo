//
//  Course+CoreDataProperties.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/15.
//  Copyright © 2018年 gao. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nonatomic) int16_t score;
@property (nonatomic) int16_t courseId;
@property (nullable, nonatomic, copy) NSString *courseName;
@property (nullable, nonatomic, retain) NSSet<Student *> *courseStudents;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addCourseStudentsObject:(Student *)value;
- (void)removeCourseStudentsObject:(Student *)value;
- (void)addCourseStudents:(NSSet<Student *> *)values;
- (void)removeCourseStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
