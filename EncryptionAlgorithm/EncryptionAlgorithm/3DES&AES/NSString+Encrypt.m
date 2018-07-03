//
//  NSString+Encrypt.m
//  IOS-Categories
//
//  Created by Jakey on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+Encrypt.h"
#import "NSData+Encrypt.h"
#import "NSData+Base64.h"

@implementation NSString (Encrypt)

-(NSString*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted base64EncodedString];
    
    return encryptedString;
}

- (NSString*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData dataWithBase64EncodedString:self] decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted base64EncodedString];
    
    return encryptedString;
}

- (NSString*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData dataWithBase64EncodedString:self] decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

//返回24位大小写字母和数字
+(NSString *)return24LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 24; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}

@end
