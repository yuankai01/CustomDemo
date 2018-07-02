//
//  CoreDataViewController.m
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//
/* <#注释#>
 https://www.jianshu.com/p/332cba029b95
 https://www.jianshu.com/p/38e6017ab1e9
 
 https://blog.csdn.net/wanna_dance/article/details/73520209
 https://blog.csdn.net/wanna_dance/article/details/73550428
 https://blog.csdn.net/willluckysmile/article/details/76464249
 https://www.jianshu.com/p/113047a478c5
 
 优点:
 1.不用写 SQL 语句,这对于有些同学来说应该是一个福音,而且 SQL 语句错误时会导致问题不便于找出来,所以这也是一个便捷错作啦
 2.代码清晰,如果有语法错误会即使提示,而不是等到运行时才知道错误.
 3.配备可视化的结构,让对于字段的增删清晰明朗
 缺点:
 1.是一个重量级的数据库管理,产生很多代码量
 2.对于复杂的联合表查询不适用
 3.出错不容易解决或找到问题,需要有很深的开发功底
 
 */

/* <#注释#>
 那我们先来了解 CoreData 的基本结构吧
 
 NSManagedObiectModel(托管对象模型)：
 该对象负责管理整个应用的所有实体以及实体之间的关联关系。当开发者使用Xcode的图形界面设计了实体与实体的关联关系之后，需要使用该对象来加载、管理应用的托管对象模型。
 
 NSPeristentStoreCoordinator(持久化存储协调器):
 负责管理底层的存储文件，例如SQLite数据库等。
 
 NSManagedObjectContext(托管对象上下文):
 该对象是Core Data的核心对象，应用对实体所做的任何 增、删、查、改 操作都必须通过该对象来完成。
 
 NSEntityDescription(实体描述):
 该对象代表了关于某个实体的描述信息，从某种程度来说，该对象相当于实体的抽象。实体描述定义了该实体的名字、实体的实现类，并用一个集合定义了该实体包含的所有属性。
 
 NSFetchRequest(抓取请求):
 抓取请求NSFetchRequest：该对象封装了查询实体的请求，包括程序需要查询哪些实体、查询条件、排序规则等。抓取请求定义了本次查询的实体的名字、抓取请求的查询条件，通过NSPredicate来表示，并用一个NSArray集合定义了所有的排序规则。
 
 NSManagedObjectContext 管理对象，上下文，持久性存储模型对象，处理数据与应用的交互
 NSManagedObjectModel 被管理的数据模型，数据结构
 NSPersistentStoreCoordinator 添加数据库，设置数据存储的名字，位置，存储方式
 NSManagedObject 被管理的数据记录
 NSFetchRequest 数据请求
 NSEntityDescription 表格实体结构
 系统创建模型文件时会自动生成关联数据库的代码，在iOS10以下和iOS10之后生成的不一样，出现了一个新类NSPersistentContainer。
 */

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "CoreDataViewCell.h"

#import "Student+CoreDataClass.h"
#import "Clazz+CoreDataClass.h"
#import "Course+CoreDataClass.h"

@interface CoreDataViewController () <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    NSURL *sqlUrl;
}

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *sectionHeaderLab;

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CoreDataViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRandomStudent)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveContextSave:) name:NSManagedObjectContextDidSaveNotification object:self.context];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 增删改查排
//插入
- (IBAction)insert:(id)sender {
    
    [self addRandomStudent];
}

// 最后来实现一开始添加的编辑和插入按钮的操作：
// 为了看到插入效果，可以把 fetchedResultsController 的fetchLimit 和 fetchBatchSize 调小一些.
- (void)addRandomStudent {
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    Student * student = [NSEntityDescription  insertNewObjectForEntityForName:@"Student"  inManagedObjectContext:self.context];

    //2.根据表Student中的键值，给NSManagedObject对象赋值
    //如果字符串数据太长 会导致插入数据库失败，如：Mrdfff-2316，是因为model中设置了name的最大长度为10。取消长度设置就好了
    student.name = [NSString stringWithFormat:@"Mr-%d",arc4random()%9999];
    student.age = arc4random()%20 + 1;
    student.sex = arc4random()%2 == 0 ?  @"美女" : @"帅哥" ;
    student.studentId = [NSString stringWithFormat:@"sd-%d",arc4random()%9999];
    //   3.保存插入的数据
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"数据插入到数据库成功");
    }else{
        NSLog(@"数据插入到数据库失败 == %@",error);
    }
    
    /* 批量插入 老操作失败
     for (NSUInteger i = 0; i < 1000; i++) {
     @autoreleasepool
     {
     Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
     
     int16_t stuId = arc4random_uniform(9999);
     //如果字符串数据太长 会导致插入数据库失败，如：Mrdfff-2316，是因为model中设置了name的最大长度为10。取消长度设置就好了.
     newStudent.name = [NSString stringWithFormat:@"student-%d", stuId];
     newStudent.studentId = [NSString stringWithFormat:@"stuId-%d",arc4random()%9999];
     newStudent.age = arc4random_uniform(10) + 10;
     }
     }
     
     //   3.保存插入的数据
     NSError *error = nil;
     if ([self.context save:&error]) {
     NSLog(@"数据插入到数据库成功");
     }else{
     NSLog(@"数据插入到数据库失败 == %@",error);
     }
     */
}

//删除
- (IBAction)delete:(id)sender {
    [self batchDelete];
    return;
    
    //创建删除请求
//    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSFetchRequest *deleRequest = [Student fetchRequest];
    //删除条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %d", 10];
    deleRequest.predicate = pre;
    //返回需要删除的对象数组
    NSArray *deleArray = [self.context executeFetchRequest:deleRequest error:nil];
    
    //从数据库中删除
    for (Student *employee in deleArray) {
        [self.context deleteObject:employee];
    }
    
//    [self.context save:nil]; // 最后不要忘了调用 save 使操作生效。
    
    NSError *error = nil;
    //保存--记住保存
    if ([self.context save:&error]) {
        NSLog(@"删除 age < 10 的数据");
    }else{
        NSLog(@"删除数据失败, %@", error);
    }
}

//批量删除 NSBatchDeleteRequest
- (void)batchDelete
{
    //NSBatchDeleteRequest 的用法和 NSBatchUpdateRequest 很相似，不同的是 NSBatchDeleteRequest 需要指定 fetchRequest 属性来进行删除；而且它是 iOS 9 才添加进来的，和 NSBatchUpdateRequest 的适用范围不一样，下面看一下示例代码：
    
    NSFetchRequest *deleteFetch = [Student fetchRequest];
    
//    deleteFetch.predicate = [NSPredicate predicateWithFormat:@"age > %@", @(10)];
    deleteFetch.predicate = [NSPredicate predicateWithFormat:@"sex = nil"];
    
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:deleteFetch];
    deleteRequest.resultType = NSBatchDeleteResultTypeObjectIDs;
    
    //执行批量删除
    //* 与查询请求NSFetchRequest不同的是，删除请求NSBatchDeleteRequest是由存储调度器来执行的*
    //实验：下面两种方法都可以起到批量删除的作用
    NSBatchDeleteResult *deleteResult = [self.context executeRequest:deleteRequest error:nil];
    NSBatchDeleteResult *deleteResult2 = [self.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.context error:nil];
    NSArray<NSManagedObjectID *> *deletedObjectIDs = deleteResult.result;

    //通知上下文数据更新
    NSDictionary *deletedDict = @{NSDeletedObjectsKey : deletedObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:deletedDict intoContexts:@[self.context]];
}

//更新
- (IBAction)update:(id)sender {
//    [self batchUpdate];
//    return;
    
    //创建查询请求
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"帅哥"];
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSFetchRequest *request = [Student fetchRequest];
    request.predicate = pre;
    
    //发送请求
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    //修改
    for (Student *employee in resArray) {
        employee.name = [NSString stringWithFormat:@"且行且珍惜_iOS%d",arc4random() % 11+ 1];
    }
    //保存
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"更新所有帅哥的的名字为“且行且珍惜_iOS”");
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
}

/* 批量更新  Batch 英  [bætʃ]   美  [bætʃ]
 n. 一批；一炉；一次所制之量
 vt. 分批处理
 这里讲的批量更新方式，用到的是集合类型中的 KVC 特性。这是什么呢？就是在 NSArray 这样的集合类型里，可以调用它的 [setValue: forKeyPath:] 方法来更新这个数组中所有元素所对应的 keypath。例如想要将上面查询出来的 students 数组里所有元素的 studentName 属性都修改成 @"anotherName"，就可以这么来写：
 [resArray setValue:@"anotherName" forKeyPath:@"studentName"];
 这样批量更新存在一个问题，就是更新前需要将要更新的数据，查询出来，加载到内存中；这在数据量非常大的时候，假如说要更新十万条数据，就比较麻烦了。
 解决办法用NSBatchUpdateRequest 批量更新。
 
 NSBatchUpdateRequest 批量更新
 NSBatchUpdateRequest 是在 iOS 8, macOS 10.10 之后新添加的 API，它是专门用来进行批量更新的。因为用上面那种方式批量更新的话，会存在一个问题，就是更新前需要将要更新的数据，查询出来，加载到内存中；这在数据量非常大的时候，假如说要更新十万条数据，就比较麻烦了，因为对于手机这种内存比较小的设备，直接加载这么多数据到内存里显然是不可能的。解决办法就是每次只查询出读取一小部分数据到内存中，然后对其进行更新，更新完之后，再更新下一批，就这样分批来处理。但这显然不是高效的解决方案。
 
 于是就有了 NSBatchUpdateRequest 这个 API。它的工作原理是不加载到内存里，而是“直接对本地数据库中数据进行更新”。这就避免了内存不足的问题；但同时，由于是直接更新数据库，所以内存中的 NSManagedObjectContext 不会知道数据库的变化，解决办法是调用 NSManagedObjectContext 的 + (void)mergeChangesFromRemoteContextSave:(NSDictionary*)changeNotificationData intoContexts:(NSArray<NSManagedObjectContext*> *)contexts;方法来告诉 context，有哪些数据更新
 
 */
- (void)batchUpdate
{
    // 根据 entity 创建
    NSBatchUpdateRequest *updateRequest = [[NSBatchUpdateRequest alloc] initWithEntity:[Student entity]];
    // 根据 entityName 创建
    NSBatchUpdateRequest *updateRequest2 = [[NSBatchUpdateRequest alloc] initWithEntityName:@"Student"];
    
    //predicate用来指定更新条件
    updateRequest.predicate = [NSPredicate predicateWithFormat:@"age >= %@", @(11)];
    
    //propertiesToUpdate 属性是一个字典，用它来指定需要更新的字段，字典里的 key 就是要更新的字段名，value 就是要设置的新值。因为 Objective-C 字典里只能存储对象类型，所以如果字段基本数据类型的的话，需要转换成 NSNumber 对象。
    updateRequest.propertiesToUpdate = @{@"name" : @"22anotherName"};
    
    /* resultType
     resultType 属性是 NSBatchUpdateRequestResultType 类型的枚举，用来指定返回的数据类型。这个枚举有三个成员：
     
     NSStatusOnlyResultType — 返回 BOOL 结果，表示更新是否执行成功
     NSUpdatedObjectIDsResultType — 返回更新成功的对象的 ID，是 NSArray<NSManagedObjectID *> * 类型。
     NSUpdatedObjectsCountResultType — 返回更新成功数据的总数，是数字类型
     */
    
    updateRequest.resultType = NSUpdatedObjectIDsResultType;
    
    //配置完 NSBatchUpdateRequest 对象后，就可以通过 context 的 - (nullable __kindof NSPersistentStoreResult *)executeRequest:(NSPersistentStoreRequest*)request error:(NSError **)error; 方法来执行批量更新了：
    NSError *error;
    NSBatchUpdateResult *updateResult = [self.context executeRequest:updateRequest error:&error];
    NSArray<NSManagedObjectID *> *updatedObjectIDs = updateResult.result;
    //executeRequest 方法返回的是 NSBatchUpdateResult 对象，里面有一个 id result 属性，它的具体类型就是前面通过枚举成员指定的类型。
    
   // 底层数据更新之后，现在要通知内存中的 context 了，调用 context 的mergeChanges 方法，第一个参数是个字典，指定要合并的数据类型（是更新还是删除、插入等）；第二个参数就是 context 数组，指定要合并到哪些 context 中去。
    
    NSDictionary *updatedDict = @{NSUpdatedObjectsKey : updatedObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:updatedDict intoContexts:@[self.context]];
}

/* 注释
 NSFetchRequest — fetchRequest 代表了一条查询请求，相当于 SQL 中的 SELECT 语句
 NSPredicate — predicate 翻译过来是谓词的意思，它可以指定一些查询条件，相当于 SQL 中的 WHERE 子句，有关 NSPredicate 的用法，可以看我之前写过的一篇文章：使用 NSPredicate 进行数据库查询
 NSSortDescriptor — sortDescriptor 是用来指定排序规则的，相当于 SQL 中的 ORDER BY 子句
 */
//查询
- (IBAction)select:(id)sender {
    /* 谓词的条件指令
     1.比较运算符 > 、< 、== 、>= 、<= 、!=
     例：@"number >= 99"
     2.范围运算符：IN 、BETWEEN
     例：@"number BETWEEN {1,5}"
     @"address IN {'shanghai','nanjing'}"
     3.字符串本身:SELF
     例：@"SELF == 'APPLE'"
     4.字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
     例：  @"name CONTAIN[cd] 'ang'"  //包含某个字符串
     @"name BEGINSWITH[c] 'sh'"    //以某个字符串开头
     @"name ENDSWITH[d] 'ang'"    //以某个字符串结束
     5.通配符：LIKE
     例：@"name LIKE[cd] '*er*'"   //\*代表通配符,Like也接受[cd].
     @"name LIKE[cd] '???er*'"
     *注*: 星号 "*" : 代表0个或多个字符
     问号 "?" : 代表一个字符
     6.正则表达式：MATCHES
     例：NSString *regex = @"^A.+e$"; //以A开头，e结尾
     @"name MATCHES %@",regex
     注:[c]*不区分大小写 , [d]不区分发音符号即没有重音符号, [cd]既不区分大小写，也不区分发音符号。
     7. 合计操作
     ANY，SOME：指定下列表达式中的任意元素。比如，ANY children.age < 18。
     ALL：指定下列表达式中的所有元素。比如，ALL children.age < 18。
     NONE：指定下列表达式中没有的元素。比如，NONE children.age < 18。它在逻辑上等于NOT (ANY ...)。
     IN：等于SQL的IN操作，左边的表达必须出现在右边指定的集合中。比如，name IN { 'Ben', 'Melissa', 'Nick' }。
     提示:
     1. 谓词中的匹配指令关键字通常使用大写字母
     2. 谓词中可以使用格式字符串
     3. 如果通过对象的key
     path指定匹配条件，需要使用%K
     */
    
    /* NSFetchRequest 还有下面这些属性
     fetchLimit — 指定结果集中数据的最大条目数，相当于 SQL 中的 LIMIT 子句
     fetchOffset — 指定查询的偏移量，默认为 0
     fetchBatchSize — 指定批处理查询的大小，设置了这个属性后，查询的结果集会分批返回
     entityName/entity — 指定查询的数据表，相当于 SQL 中的 FROM 语句
     propertiesToGroupBy — 指定分组规则，相当于 SQL 中的 GROUP BY 子句
     propertiesToFetch — 指定要查询的字段，默认会查询全部字段
     */
    
//    [self asynSelect];
//    return;
    
    //创建查询请求
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSFetchRequest *request = [Student fetchRequest];
    //查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"美女"];
    request.predicate = pre;
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    // 每页显示多少条数据
    //request.fetchLimit = 6;
    //发送查询请求
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    
    for (Student *stu in resArray) {
        NSLog(@"查询所有的美女==name = %@,age = %hd,studentId = %@",stu.name,stu.age,stu.studentId);
    }
    
    NSArray<NSManagedObjectID *> *updatedObjectIDs = resArray;
    NSDictionary *updateDic = @{NSUpdatedObjectsKey : updatedObjectIDs};
    
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:updateDic intoContexts:@[self.context]];
    
    //要想显示出查询数据，需要重写numberRow方法，把查询的结果array当做对应的行数

    /*fetch快捷代码
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"<#Entity name#>" inManagedObjectContext:<#context#>];
     [fetchRequest setEntity:entity];
     // Specify criteria for filtering which objects to fetch
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
     [fetchRequest setPredicate:predicate];
     // Specify how the fetched objects should be sorted
     NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
     ascending:YES];
     [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
     
     NSError *error = nil;
     NSArray *fetchedObjects = [<#context#> executeFetchRequest:fetchRequest error:&error];
     if (fetchedObjects == nil) {
     <#Error handling code#>
     }
     */
}

//多线程查询
//https://blog.csdn.net/youshaoduo/article/details/53695517?utm_source=itdadao&utm_medium=referral
- (void)asynSelect
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    //查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"美女"];
    request.predicate = pre;
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    // 每页显示多少条数据
    //request.fetchLimit = 6;

    NSAsynchronousFetchRequest *asynRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:request completionBlock:^(NSAsynchronousFetchResult * _Nonnull result) {
        for (Student *stu in result.finalResult) {
            NSLog(@"asynRequest查询所有的美女==name = %@,age = %hd,studentId = %@",stu.name,stu.age,stu.studentId);
        }
        
        NSArray<NSManagedObjectID *> *updatedObjectIDs = result.finalResult;
        NSDictionary *updateDic = @{NSUpdatedObjectsKey : updatedObjectIDs};
        
        [NSManagedObjectContext mergeChangesFromRemoteContextSave:updateDic intoContexts:@[self.context]];
        
        //要想显示出查询数据，需要重写numberRow方法，把查询的结果array当做对应的行数
    }];
    
    //发送查询请求
    [self.context executeRequest:asynRequest error:nil];
}

//排序
- (IBAction)order:(id)sender {
    //创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
//    NSSortDescriptor *studentId = [NSSortDescriptor sortDescriptorWithKey:@"studentId"ascending:YES];
    
    request.sortDescriptors = @[ageSort];
    //发送请求
    NSError *error = nil;
    NSArray<NSManagedObjectID *> *resArray = [_context executeFetchRequest:request error:&error];
    
    if (error == nil) {
//        NSLog(@"按照age和number排序");
        for (Student *stu in resArray) {
            NSLog(@"按照age和number排序==age = %hd,studentId = %@,name = %@,",stu.age,stu.studentId,stu.name);
        }
        
        NSDictionary *orderDic = @{NSUpdatedObjectsKey : resArray};
        [NSManagedObjectContext mergeChangesFromRemoteContextSave:orderDic intoContexts:@[self.context]];
        //要想显示出排序数据结果，需要重写numberRow方法，把查询的结果array当做对应的行数
    }else{
        NSLog(@"排序失败, %@", error);
    }
}

#pragma mark - 实体关联
//多个实体的增删改查类似单个表的增删改查。多表关联主要在于数据删除操作是否关联，以及关联的程度。
//单个箭头表示的是对一的关系，双箭头就表示对多的关系。
/* 删除规则
 删除规则（Delete Rule）规定了这条数据删除时，它所关联的数据该执行什么样的操作。这里有四种规则可以选择：
 * No Action    不做任何操作
 * Nullify      其他关联的实体会把改对象删除
 * Cascade      级联  所有关联的实体都会删除
 * Deny         否认  其他关联的实体都为nil时该对象才会被删除
 
 下面通过一个例子来说明这四个类型都有什么效果：

 假如我们删除一名学生，
 如果把 Delete Rule 设置成 No Action，它表示不做任何，这个时候学生所在的班级（Class.classStudents）依然会以为这名学生还在这个班级里，同时课程记录里也会以为学习这门课程（Course.courseStudents）的所有学生们里，还有这位学生，当我们访问到这两个属性时，就会出现异常情况，所以不建议设置这个规则；
 如果设置成 Nullify，对应的，班级信息里就会把这名学生除名，课程记录里也会把这名学生的记录删除掉；
 如果设置成 Cascade，它表示级联操作，这个时候，会把这个学生关联的班级以及课程，一股脑的都删除掉，
 如果 Clazz 和 Course 里还关联着其他的表，而且也设置成 Cascade 的话，就还会删除下去；
 如果设置成 Deny，只有在学生关联的班级和课程都为 nil的情况下，这个学生才能被删除，否则，程序就会抛出异常。
 
 所以这里，我们把 Student 的 studentClass 和 studentCourses 的删除规则设置成 Nullify 是最合适的。
 */
- (void)associatedEntity
{
    Student *student = [NSEntityDescription  insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    
    Clazz *clazz = [[Clazz alloc] initWithContext:self.context];
    // configure clazz
    // ....
    
    student.studentClass = clazz;
    
    Course *english = [[Course alloc] initWithContext:self.context];
    Course *math = [[Course alloc] initWithContext:self.context];
    
    [student addStudentCoursesObject:english];
    [student addStudentCourses:[NSSet setWithObjects:english, math, nil]];
    
    [self.context save:nil];
}

#pragma mark - CoreData并发操作
/* 使用后台 managedObjectContext
 通常情况下，CoreData 的增删改查操作都在主线程上执行，那么对数据库的操作就会影响到 UI 操作，这在操作的数据量比较小的时候，执行的速度很快，我们也不会察觉到对 UI 的影响，但是当数据量特别大的时候，再把 CoreData 的操作放到主线程中就会影响到 UI 的流畅性。自然而然地我们就会想到使用后台线程来处理大量的数据操作。
 NSManagedObjectContext 在创建时，可以传入 ConcurrencyType 来指定 context 的并发类型。
 指定 NSMainQueueConcurrencyType 就是我们平时创建的运行在主队列的 context；
 指定成 NSPrivateQueueConcurrencyType 的话，context 就会运行在它所管理的一个私有队列中；
 另外还有 NSConfinementConcurrencyType 是适用于旧设备的并发类型，现在已经被废弃了，所以实际上只有两种并发类型。
 */
- (void)coreDataQueue
{
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    backgroundContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    //在最新的 iOS 10 中，CoreData 栈的创建被封装在了 NSPersistentContainer 类中，用它来创建 backgroundContext 更加简单：
    
//    NSManagedObjectContext *backgroundContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer.newBackgroundContext;
    [backgroundContext performBlock:^{
        
        for (NSUInteger i = 0; i < 100000; i++) {
            
            NSString *name = [NSString stringWithFormat:@"student-%d", arc4random_uniform(9999)];
            int16_t age = arc4random_uniform(10) + 10;
            int16_t stuId = arc4random_uniform(9999);
            Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:backgroundContext];
            student.name = name;
            student.age = age;
//            student.id = stuId;
        }
        NSError *error;
        [backgroundContext save:&error];
//        [self.logger dealWithError:error
//                          whenFail:@"failed to insert"
//                       whenSuccess:@"insert success"];
        
    }];
    
}

/* NSManagedObjectContextDidSaveNotification 通知
 后台插入数据之后，还没有完，因为数据是通过后台的 context 写入到本地的持久化数据库的，所以这时候主队列的 context 是不知道本地数据变化的，所以还需要通知到主队列的 context：“数据库的内容有变化啦，看看你有没有需要合并的”。这个过程可以通过监听一条通知来实现。这个通知就是 NSManagedObjectContextDidSaveNotification，在每次调用 NSManagedObjectContext 的 save:方法时都会自动发送，通知中的 userInfo 中包含了修改的数据，可以通过 NSInsertedObjectsKey、NSUpdatedObjectsKey、 NSDeletedObjectsKey 这三个 key 获取到。
 收到通知之后，只需要调用 [self.mainContext mergeChangesFromContextDidSaveNotification:note] 就可以将修改的数据合并到主线程的 context。
 */
- (void)receiveContextSave:(NSNotification *)note
{
    [self.context mergeChangesFromContextDidSaveNotification:note];
    
   // 注意：通知的 userInfo 里保存的 managedObjects 不可以直接在另一个线程的 context 中直接使用！也就是managedObject不是跨线程的，如果想要在别的线程操作，必须通过 objectId 在另一个 context 里再重新获得这个 object。
    NSSet<Student *> *managedObjects = note.userInfo[NSInsertedObjectsKey];
    NSManagedObjectID *studentId = managedObjects.allObjects[0].objectID;
    
    [self.context performBlock:^{
        
        // 这是错的
        // Student *wrongStudent = managedObjects.allObjects[0];
        
        // 应该这么做
        Student *student = [self.context objectWithID:studentId];
        // modify student...
    }];
    
}

#pragma mark - 版本升级 数据迁移
/* 注释
 这里说一下新增加的2个参数的意义：
 NSMigratePersistentStoresAutomaticallyOption = YES，那么Core Data会试着把之前低版本的出现不兼容的持久化存储区迁移到新的模型中，这里的例子里，Core Data就能识别出是新表，就会新建出新表的存储区来。
 NSInferMappingModelAutomaticallyOption = YES,这个参数的意义是Core Data会根据自己认为最合理的方式去尝试MappingModel，从源模型实体的某个属性，映射到目标模型实体的某个属性。
 Migrate : 英  [maɪ'greɪt; 'maɪgreɪt]   美  ['maɪɡret]
 vi. 移动；随季节而移居；移往
 */
- (void)versionModel
{
    //创建持久化存储助理：数据库
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    //请求自动轻量级迁移
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    NSError *error = nil;
    //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:options error:&error];
}

#pragma mark - tableView
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 16;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // sections 是一个 NSFetchedResultsSectionInfo 协议类型的数组，保存着所有 section 的信息
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // sectionInfo 里的 numberOfObjects 属性表示对应 section 里的结果数量
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoreDataViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 通过这个方法可以直接获取到对应 indexPath 的实体类对象
    Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withStudent:student];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self updateSectionTitle:section];
    return self.sectionHeaderLab;
}

- (void)updateSectionTitle:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    self.sectionHeaderLab.text = [NSString stringWithFormat:@"section === %ld ===count === %ld",section + 1,sectionInfo.numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.context deleteObject:student];
        [self.context save:nil];
    }
}

// 修改后的configureCell 方法
- (void)configureCell:(CoreDataViewCell *)cell withStudent:(Student *)student {
    cell.nameLab.text = [NSString stringWithFormat:@"姓名：%@",student.name];
    cell.sexLab.text = [NSString stringWithFormat:@"性别：%@",student.sex];
    cell.ageLab.text = [NSString stringWithFormat:@"年龄：%d",student.age];
    cell.workNumLab.text = [NSString stringWithFormat:@"工号ID：%@",student.studentId];
}

//想要实现 tableView 的数据同步更新可以按下面的代码来实现这几个 delegate 方法：
#pragma mark - NSFetchedResultsControllerDelegate
 // 数据内容将要发生变化时会回调
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // 在这里调用 beginUpdates 通知 tableView 开始更新，注意要和 endUpdates 联用
    [self.tableView beginUpdates];
}

 // 数据内容发生变化之后会回调
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // 更新完后会回调这里，调用 tableView 的 endUpdates.
    [self.tableView endUpdates];
}

// 对应 indexPath 的数据发生变化时会回调这个方法
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    // beginUpdates 之后，这个方法会调用，根据不同类型，来对tableView进行操作，注意什么时候该用 indexPath，什么时候用 newIndexPath.
//    [self.tableView reloadData];
//    return;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] withStudent:anObject];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
    
    [self updateSectionTitle:indexPath.section];
}

 // section 发生变化时会回调这个方法
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
}

 // 返回对应 section 的标题
- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return @"aafddd";
}

#pragma mark - 懒加载 *******
- (UILabel *)sectionHeaderLab
{
    if (!_sectionHeaderLab) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 30)];
        label.backgroundColor =  [UIColor cyanColor];
        _sectionHeaderLab = label;
    }
    
    return _sectionHeaderLab;
}

// 使用懒加载的方式初始化
- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        // url 为CoreDataDemo.xcdatamodeld，注意扩展名为 momd，而不是 xcdatamodeld 类型
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    
    return _managedObjectModel;
}

// 创建好 managedObjectModel 后就可以来创建 persistentStoreCoordinator 了，因为它的创建需要用到 managedObjectModel，managedObjectModel 告诉了persistentStoreCoordinator 数据模型的结构，然后 persistentStoreCoordinator 会根据对应的模型结构创建持久化的本地存储。
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        // 创建 coordinator 需要传入 managedObjectModel
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        // 指定本地的 sqlite 数据库文件
        NSURL *sqliteURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"CoreData_db.sqlite"];
        sqlUrl = sqliteURL;
        NSLog(@"coredata sqliteURL === %@",sqliteURL);
        
        /* <#注释#> 注意前往路径要去掉前面的file:// 和 后面的数据库名Student.sqlite
         打印路径：sqliteURL === file:///Users/gao/Library/Developer/CoreSimulator/Devices/F2777647-89EB-4D95-B6EE-ADCCBC93A404/data/Containers/Data/Application/30CC359C-3CF5-4CC3-926B-228C03910E20/Documents/Student.sqlite
         前往路径：/Users/gao/Library/Developer/CoreSimulator/Devices/F2777647-89EB-4D95-B6EE-ADCCBC93A404/data/Containers/Data/Application/30CC359C-3CF5-4CC3-926B-228C03910E20/Documents
         */
        NSError *error;
        // 为 persistentStoreCoordinator 指定本地存储的类型，这里指定的是 SQLite
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:sqliteURL
                                                        options:nil
                                                          error:&error];
        if (error) {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);
        }
        
        if (error) {
            NSLog(@"添加数据库失败:%@",error);
        } else {
            NSLog(@"添加数据库成功");
        }
    }
    
    return _persistentStoreCoordinator;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

//上面两步都完成之后，下面来创建 managedObjectContext, 这也是平时操作 CoreData 主要会用到的对象：
- (NSManagedObjectContext *)context {
    if (!_context) {
        // 指定 context 的并发类型： NSMainQueueConcurrencyType 或 NSPrivateQueueConcurrencyType
        _context = [[NSManagedObjectContext alloc ] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _context;
}

//NSFetchedResultsController + CoreData + UITableView的完美结合 https://www.jianshu.com/p/8ab36789b846
- (NSFetchedResultsController<Student *> *)fetchedResultsController {
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [Student fetchRequest];
        
//        //定义分组和排序规则(按章分组,章节均是 升序 排列)
//        NSSortDescriptor*sortDescriptor1 = [[NSSortDescriptor alloc]initWithKey:@"chapterNum" ascending:ascending1];
//        NSSortDescriptor*sortDescriptor2= [[NSSortDescriptor alloc]initWithKey:@"sectionNum" ascending:ascending2];
//        //把排序和分组规则添加到请求中
//        [fetchRequest sortDescriptors:@[sortDescriptor1,sortDescriptor2]];
        
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"studentId" ascending:YES]];
        fetchRequest.fetchBatchSize = 10;   //分批返回 每批10条
//        fetchRequest.fetchLimit = 200;      //最多200条
//        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"sex = %@", @"美女"];
        
        //sectionNameKeyPath与sortDescriptors须保持一致，多个的话，顺序保持一致。或者直接置为nil。
//        NSFetchedResultsController *fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:@"name" cacheName:@"StudentTable"];
        NSFetchedResultsController *fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:@"nameCache"];
        
        fetchController.delegate = self;
        
        NSError *error;
        [fetchController performFetch:&error];
        
        /* 注释
         1) NSFetchRequest: 获取对象的请求用于获取对象. 可以设置request的entityName, predicate以及sortDescriptors等属性圈定对象并排序.
         重要的：在调用此方法之后，您不能修改fetchRequest。例如，您不能更改它的谓词或排序顺序。
         2) NSManagedObjectContext: 上下文,持有获取的对象. 通过上下文可以操作coreData,修改数据,但是如果未save,只是修改了内存中数据,并未保存到磁盘.
         3) sectionNameKeyPath: 获取的对象进行分组的参数.
         4) cacheName:缓存名字.个人理解:只缓存部分数据在磁盘上面,在需要请求时,根据时间戳检查本地缓存的数据,但是处理任何非法的或任务就不检查，可以设置为nil.(API解释: cacheName - Section info is cached persistently to a private file under this name. Cached sections are checked to see if the time stamp matches the store, but not if you have illegally mutated the readonly fetch request, predicate, or sort descriptor.)
         
         */
        
//        [[[Logger alloc] init] dealWithError:error whenFail:@"fetch failed" whenSuccess:@"fetch success"];
        
        _fetchedResultsController = fetchController;
    }
    
    return _fetchedResultsController;
}

@end
