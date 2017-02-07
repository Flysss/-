//
//  Memory.m
//  NetCarOne
//
//  Created by 李徽 on 16/9/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "Memory.h"

@implementation Memory

+ (NSString *)getTokenFromUserdefault{

    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    NSString * token =[userdefault objectForKey:@"TOKEN"];
    return token;
}

+ (void)saveTokenToUserdefaultWithString:(NSString *)token{

    NSUserDefaults * userderfault = [NSUserDefaults standardUserDefaults];
    [userderfault setObject:token forKey:@"TOKEN"];
}

@end
