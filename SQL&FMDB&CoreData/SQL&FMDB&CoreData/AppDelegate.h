//
//  AppDelegate.h
//  SQL&FMDB&CoreData
//
//  Created by gao on 2018/6/11.
//  Copyright © 2018年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

