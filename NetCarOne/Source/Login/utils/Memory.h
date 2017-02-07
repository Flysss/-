//
//  Memory.h
//  NetCarOne
//
//  Created by 李徽 on 16/9/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memory : NSObject

+(NSString *)getTokenFromUserdefault;

+(void)saveTokenToUserdefaultWithString:(NSString *)token;

@end
