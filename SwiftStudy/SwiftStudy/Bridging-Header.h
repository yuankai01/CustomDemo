//
//  Bridging-Header.h
//  SwiftStudy
//
//  Created by gao on 2018/6/21.
//  Copyright © 2018年 gao. All rights reserved.
//
/* 手动创建桥接文件：
 https://www.jianshu.com/p/7c941d274f5a
 https://blog.csdn.net/qq_25639809/article/details/60878785
 
 二、适用于任何情况
 1.选中工程,点击New File ->iOS-> Header File;
 2.点击Next,为桥接文件命名;
 3.点击Create;
 4.在Build Setting -> Objective-C Bridging Header添加桥接文件路径，路径的格式为：
 $(SRCROOT)/Bridging-Header.h
 
 如果你建立在工程里面的文件夹里了，需要在中间写上文件夹的名字，如：
 $(SRCROOT)/文件夹名/Bridging-Header.h；
 
 5.编译一下，路径填写不对编译会报错！！！
 编译成功 在桥接文件里面使用#import引入相应的OC头文件，就可以使用引入的OC文件了;
 */

#ifndef Bridging_Header_h
#define Bridging_Header_h

#import <CommonCrypto/CommonDigest.h>

/*
 测试环境
 15611111114  a123456
 15507398328 a123456
 
 12312312311   a123456   12312312312     a123456
 
 驾驶舱
 18100001007  a123456
 18300000003 a123456
 
 
 生产环境：
 15507398326  a123456
 17100000000  a123456
 
 无驾驶舱权限
 18100001007  a123456
 15507398324  a123456
 
 */

#ifndef ServerDefine_h
#define ServerDefine_h

//#define DEV_SERVER
//#define TEST_SERVER
#define PROD_SERVER


#endif /* ServerDefine_h */

/**
 *  定义三个服务器，根据需要注释相关 define
 */

#pragma mark -- 开发环境 --
#ifdef DEV_SERVER


//#define API_BASE_URL               @"http://10.111.10.26:8080/dangjian/v1"  //接口的地址 //周肖
#define API_BASE_URL               @"http://10.111.10.99:8080/dangjian/v1"  //接口的地址 //张龙
//#define API_BASE_URL               @"http://10.111.10.33:8080/dangjian/v1"  //接口的地址 //黄磊

#endif


#pragma mark -- 测试环境 --
#ifdef TEST_SERVER

#define API_BASE_URL               @"http://10.111.3.5:8082/dangjian/v1"    //测试内网
//#define API_BASE_URL               @"http://10.111.11.35:8080/dangjian/v1"    //卞华林


#endif

#pragma mark -- 预发布环境、压力测试环境 --
#ifdef PRE_SERVER

#define API_BASE_URL               @"http://vice.iotcetc.com:8080/dangjian/v1"  //测试外网 压力测试华宁

#endif

#pragma mark -- 发布环境 --
#ifdef PROD_SERVER

#ifdef SERVER_SSL
#define API_BASE_URL                @"https://api.iotcetc.com:8082/dangjian/v1"  //新的接口的地址
#else
#define API_BASE_URL                @"http://meeting.iotcetc.com:8080/dangjian/v1"  //新的接口的地址
#endif

#endif


#endif /* Bridging_Header_h */
