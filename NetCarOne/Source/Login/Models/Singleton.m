//
//  Singleton.m
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "Singleton.h"
static Singleton * singleton = nil;

@implementation Singleton
+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    static dispatch_once_t once;
    dispatch_once(&once,^{
    
        singleton = [super allocWithZone:zone];
    });
    return singleton;
}
-(instancetype)init{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        singleton = [super init];
        singleton.headImage = [[NSString alloc]init];
        singleton.mobileNumber = [[NSString alloc]init];
        singleton.gender = 0;
        singleton.mailboxNumber = [[NSString alloc]init];
    });
    return singleton;
}
+ (Singleton *)shareSingleton{

    return [[self alloc]init];
}
+ (id)copyWithZone:(struct _NSZone *)zone{

    return singleton;
}
+(id)mutableCopyWithZone:(struct _NSZone*)zone{

    return singleton;
}
- (id)copyWithZone:(struct _NSZone *)zone{

    return singleton;
}
-(id)mutableCopyWithZone:(struct _NSZone *)zone{

    return singleton;
}
@end
