//
//  Employees+CoreDataProperties.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//
//

/* <#注释#>
 Model.xcdatamodeld 如果modul选择了Current Product Module，则对应的类前面后有个点，编译不通过，用默认的global即可。

 */

#import "Employees+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employees (CoreDataProperties)

+ (NSFetchRequest<Employees *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *address;
@property (nonatomic) int16_t workNum;
@property (nonatomic) int16_t phone;

@end

NS_ASSUME_NONNULL_END
